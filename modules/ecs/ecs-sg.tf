resource "aws_security_group" "ecs_sg" {
    name        = "ecs-sg"
    description = "Used in ${var.env}
    vpc_id      = "${var.aws_vpc}

    tags {
        Env     = "${var.env}"
        Cluster = "${var.cluster}"
    }
}

resource "aws_security_group_rule" "esc_egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.ecs_sg.id}"
    
}


resource "aws_security_group" "alb-ecs" {
  name   = "elb-sg"
  vpc_id = "${var.aws_vpc}"

  tags {
    Environment = "${var.env}"
  }
}

resource "aws_security_group_rule" "alb-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb-esc.id}"
}

resource "aws_security_group_rule" "alb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb.id}"
}
