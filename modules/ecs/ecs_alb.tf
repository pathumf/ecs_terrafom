resource "aws_alb_target_group" "ecs_target" {
  name                 = "ecs-target"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"

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
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${aws_security_group.alb-ecs.id}"]

  tags {
    Environment = "${var.env}"
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs_target.id}"
    type             = "forward"
  }
}