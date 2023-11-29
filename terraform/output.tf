output "custom_domain" {
  value = "https://${aws_acm_certificate.www.domain_name}"
}
