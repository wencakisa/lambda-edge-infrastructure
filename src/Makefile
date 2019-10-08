ORIGIN_RESPONSE_FUNCTION_ARN = "arn:aws:lambda:us-east-1:ms-feeds-staging-image-resize-origin-response"
VIEWER_REQUEST_FUNCTION_ARN = "arn:aws:lambda:us-east-1:ms-feeds-staging-image-resize-viewer-request"

ARCHIVE_NAME = lambda.zip

deploy-origin-response:
	aws lambda update-function-code --function-name $(ORIGIN_RESPONSE_FUNCTION_ARN) --zip-file fileb://origin-response-function/$(ARCHIVE_NAME) --publish

deploy-viewer-request:
	aws lambda update-function-code --function-name $(VIEWER_REQUEST_FUNCTION_ARN) --zip-file fileb://viewer-request-function/$(ARCHIVE_NAME) --publish

deploy: deploy-origin-response deploy-viewer-request

.DEFAULT_GOAL := deploy
