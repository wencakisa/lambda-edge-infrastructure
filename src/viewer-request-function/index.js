"use strict";

const querystring = require("querystring");

exports.handler = (event, context, callback) => {
  const request = event.Records[0].cf.request;

  // parse the querystrings key-value pairs. In our case it would be d=100x100
  const params = querystring.parse(request.querystring);

  // if there is no dimension attribute, just pass the request
  if (!params.d) {
    callback(null, request);
    return;
  }

  // read the dimension parameter value = width x height and split it by 'x'
  const dimensionMatch = params.d.split("x");

  // set the width and height parameters
  let width = dimensionMatch[0];
  let height = dimensionMatch[1];

  // fetch the uri of original image
  let fwdUri = request.uri;
  // parse the prefix, image name and extension from the uri.
  // In our case /images/image.jpg
  const match = fwdUri.match(/(.*)\/(.*)\.(.*)/);

  let prefix = match[1];
  let imageName = match[2];
  let extension = match[3];

  let url = [];
  // build the new uri to be forwarded upstream
  url.push(prefix);
  url.push(width + "x" + height);
  url.push(imageName + "." + extension);

  fwdUri = url.join("/");

  // final modified url is of format /images/200x200/image.jpg
  request.uri = fwdUri;
  callback(null, request);
};
