locals {
  project = "salsabyte"

  default_region = "us-east-1"
  zone_a = "${local.default_region}a"
  zone_b = "${local.default_region}b"

  common_tags = {
     Owner   = "terraform"
     Project = local.project
  }
}
