resource "aws_iam_user" "bedrock_dev_view" {
  name = "bedrock-dev-view"
  tags = module.tags.result
}

resource "aws_iam_user_policy_attachment" "bedrock_dev_view_readonly" {
  user       = aws_iam_user.bedrock_dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_access_key" "bedrock_dev_view" {
  user = aws_iam_user.bedrock_dev_view.name
}

