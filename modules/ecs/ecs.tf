
resource "aws_launch_configuration" "ecs_lc" {
    name_prefix     = "${var.env}_${var.cluster}-"
    mage_id             = "${var.aws_ami}"
    instance_type        = "${var.instance_type}"
    security_groups      = ["${aws_security_group.ecs_sg.id}"]
    user_data            = "${data.template_file.user_data.rendered}"
    iam_instance_profile = "${awa_iam_instance_profile.ecs.id}"
    key_name             = "${var.key_name}"

    lifecycle {
    create_before_destroy = true
  }
    
}

data "aws_subnet_ids" "vpc_subnet" {
    vpc_id  = "${var.aws_vpc}
}


resource "aws_autoscaling_group" "ecs_asg" {
  name                 = "${var.environment}_${var.cluster}-asg"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  force_delete         = true
  health_check_grace_period = 300
  health_check_type = "ELB"
  launch_configuration = "${aws_launch_configuration.ecs_lc.id}"
  vpc_zone_identifier  = "${element(data.aws_subnet_ids.vpc_subnet.ids, count.index)}"
  target_group_arns    =  ["${aws_alb_target_group.ecs_target.arn}"]


  tag {
    key                 = "Name"
    value               = "${var.env}_ecs_${var.cluster}-asg"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Environment"
    value               = "${var.env}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Cluster"
    value               = "${var.cluster}"
    propagate_at_launch = "true"
  }

}


resource "aws_ecs_cluster" "ecs" {
    name = "${var.cluster}"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-deploy"
  cluster         = "${aws_ecs_cluster.ecs.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_role.arn}"

}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "ecs_task"
  container_definitions = "${template_file.ecs_task.rendered}"
}