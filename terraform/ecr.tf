resource "aws_ecr_repository" "sb_app" {
  name                 = "sb_app"
  tags = local.common_tags
}
