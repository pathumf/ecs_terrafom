resource "aws_alb_target_group" "ecs_target" {
  name                 = "${var.target_group}"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${var.aws_vpc}"

  health_check {
    path     = "${var.health_check_path}"
    protocol = "HTTP"
  }

  tags {
    Environment = "${var.env}"
  }
}

resource "aws_alb" "alb" {
  name            = "ecs-alb"
  subnets         = "${var.vpc_subnets_id}"
  security_groups = ["${aws_security_group.alb-ecs.id}"]
 

  tags {
    Environment = "${var.env}"
  }

}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs_target.arn}"
    type             = "forward"
  }
}

resource "aws_elb" "internal-elb" {
  name = "es-elb-internal"
  subnets = "${var.vpc_subnets_id}"
  security_groups = ["${aws_security_group.alb-ecs.id}"]
  internal = "true"

  listener {
    instance_port     = 9200
    instance_protocol = "tcp"
    lb_port           = 9200
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 9000
    instance_protocol = "tcp"
    lb_port           = 9000
    lb_protocol       = "tcp"
  }

    listener {
    instance_port     = 2003
    instance_protocol = "tcp"
    lb_port           = 2003
    lb_protocol       = "tcp"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:9200"
    interval            = 30
  }

}