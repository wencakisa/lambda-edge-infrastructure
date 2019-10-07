"use strict";

const querystring = require("querystring");

const AWS = require("aws-sdk");
const S3 = new AWS.S3({
  signatureVersion: "v4"
});
const Sharp = require("sharp");

const BUCKET = "ms-feeds-staging-s3-bucket";

exports.handler = (event, context, callback) => {
  let response = event.Records[0].cf.response;

  if (response.status == 404) {
    let request = event.Records[0].cf.request;
    let params = querystring.parse(request.querystring);

    // If there is no dimension attribute, just pass the response
    if (!params.d) {
      callback(null, response);
      return;
    }

    let path = request.uri.substring(1);

    // Parse the width, height and image name
    // Ex: path = images/200x200/image.jpg
    let match = path.match(/(\d+)x(\d+)\/(.*)\.(jpg|jpeg|png)/);

    let width = parseInt(match[1], 10);
    let height = parseInt(match[2], 10);

    let requiredFormat = match[4] == "jpg" ? "jpeg" : match[4];

    let originalKey = path.split(`/${width}x${height}/`).join("/");

    // Get the source image file
    S3.getObject({ Bucket: BUCKET, Key: originalKey })
      .promise()
      // Perform the resize operation
      .then(data =>
        Sharp(data.Body)
          .resize(width, height)
          .toFormat(requiredFormat)
          .toBuffer()
      )
      .then(buffer => {
        let contentType = `image/${requiredFormat}`;
        // Save the resized object to S3 bucket with appropriate object key.
        S3.putObject({
          Body: buffer,
          Bucket: BUCKET,
          ContentType: contentType,
          CacheControl: "max-age=31536000",
          Key: path,
          StorageClass: "STANDARD"
        })
          .promise()
          .catch(() => {
            console.log("Exception while writing resized image to bucket");
          });

        // generate a binary response with resized image
        response.status = 200;
        response.body = buffer.toString("base64");
        response.bodyEncoding = "base64";
        response.headers = {
          "content-type": [{ key: "Content-Type", value: contentType }]
        };

        callback(null, response);
        return;
      })
      .catch(err => {
        console.log("Exception while reading source image :%j", err);
      });
  } else {
    callback(null, response);
    return;
  }
};
