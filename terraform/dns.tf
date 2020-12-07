resource "aws_route53_record" "petclinic" {
  zone_id = var.dns_zone_id
  name    = "www.${var.project}.${terraform.workspace}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_elb.petclinic.dns_name]
}
