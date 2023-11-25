resource "aws_codestarconnections_connection" "connection" {
  name          = "connection"
  provider_type = "GitHub"
}
