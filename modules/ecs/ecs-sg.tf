

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
  to_port           = 5601
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb-ecs.id}"
}

resource "aws_security_group_rule" "alb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb-ecs.id}"
}

resource "aws_security_group" "ecs_sg" {
    name    = "ecs-sg"
    vpc_id  = "${var.aws_vpc}"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port   = 80
        to_port     = 5601
        protocol    = "tcp"
        security_groups  = ["${aws_security_group.alb-ecs.id}"]
    }

    tags {
        Environment    = "${var.env}"
    }
}


