resource "aws_route53_zone" "main" {
  name = "perf.local"
  vpc_id = "${var.aws_vpc}"

  tags {
    Environment = "main"
  }

}


resource "aws_route53_record" "es" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "es"
   type = "A"

   alias {
    name = "${aws_elb.internal-elb.dns_name}"
    zone_id = "${aws_elb.internal-elb.zone_id}"
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "shipper" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "shipper"
   type = "A"

   alias {
    name = "${aws_elb.internal-elb.dns_name}"
    zone_id = "${aws_elb.internal-elb.zone_id}"
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "app" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "app"
   type = "A"

   alias {
    name = "${aws_elb.internal-elb.dns_name}"
    zone_id = "${aws_elb.internal-elb.zone_id}"
    evaluate_target_health = true
  }
}