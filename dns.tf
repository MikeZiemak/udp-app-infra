resource "aws_route53_zone" "private_dns_zone" {
  name = "udpapp.internal"
  vpc {
    vpc_id = aws_vpc.main.id
  }
}

resource "aws_route53_record" "private_a_record" {
  zone_id = aws_route53_zone.private_dns_zone.zone_id
  name    = "backend.udpapp.internal"
  type    = "A"

  alias {
    name                   = aws_lb.udp_nlb.dns_name
    zone_id                = aws_lb.udp_nlb.zone_id
    evaluate_target_health = false
  }
}
