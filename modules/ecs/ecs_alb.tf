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
  subnets         = "${element(data.aws_subnet_ids.vpc_subnet.ids, count.index)}"
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