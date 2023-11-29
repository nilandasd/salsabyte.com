data "aws_route53_zone" "public" {
  name         = "salsabyte.com"
  private_zone = false
}

resource "aws_acm_certificate" "www" {
  domain_name       = "www.salsabyte.com"
  validation_method = "DNS"
}

resource "aws_route53_record" "www_validation" {
  for_each = {
    for dvo in aws_acm_certificate.www.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public.zone_id
}

resource "aws_acm_certificate_validation" "www" {
  certificate_arn         = aws_acm_certificate.www.arn
  validation_record_fqdns = [for record in aws_route53_record.www_validation : record.fqdn]
}

resource "aws_route53_record" "www" {
  name    = aws_acm_certificate.www.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.public.zone_id

  alias {
    name                   = aws_lb.salsabyte.dns_name
    zone_id                = aws_lb.salsabyte.zone_id
    evaluate_target_health = false
  }
}

