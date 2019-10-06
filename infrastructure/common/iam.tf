data "template_file" "lambda_role" {
  template = file("${path.module}/../definitions/lambda_role.json")
}

resource "aws_iam_role" "lambda_edge_role" {
  name               = "lambda-edge-role"
  assume_role_policy = data.template_file.lambda_role.rendered
}
