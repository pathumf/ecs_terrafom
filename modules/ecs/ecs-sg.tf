resource "aws_security_group" "ecs_sg" {
    name        = "${var.env}_${var.cluster}
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