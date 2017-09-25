
resource "aws_launch_configuration" "ecs_lc" {
    name_prefix     = "${var.env}_${var.cluster}-"
    image_id             = "${var.aws_ami}"
    instance_type        = "${var.instance_type}"
    security_groups      = ["${aws_security_group.ecs_sg.id}"]
    user_data            = "${template_file.user_data.rendered}"
    iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
    key_name             = "${var.key_name}"

    lifecycle {
    create_before_destroy = true
  }
    
}



resource "aws_autoscaling_group" "ecs_asg" {
  name                 = "${var.env}_${var.cluster}-asg"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  force_delete         = true
  health_check_grace_period = 300
  health_check_type = "EC2"
  launch_configuration = "${aws_launch_configuration.ecs_lc.id}"
  vpc_zone_identifier  = "${var.vpc_subnets_id}"
  target_group_arns    = ["${aws_alb_target_group.ecs_target.arn}"]
  load_balancers            = ["${aws_elb.internal-elb.name}"]
  

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

resource "aws_ecs_service" "ecs_service_perf-client" {
  name            = "ecs-perf-client"
  cluster         = "${aws_ecs_cluster.ecs.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task_perf-client.arn}"
  desired_count   = 1
}

resource "aws_ecs_task_definition" "ecs_task_perf-client" {
  family                = "perf-client"
  container_definitions = "${template_file.ecs_task_perf-client.rendered}"
}

resource "aws_ecs_service" "ecs_service_gatdemo-server" {
  name            = "ecs-gatdemo-server"
  cluster         = "${aws_ecs_cluster.ecs.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task_gatdemo-server.arn}"
  desired_count   = 1
}

resource "aws_ecs_task_definition" "ecs_task_gatdemo-server" {
  family                = "gatdemo-server"
  container_definitions = "${template_file.ecs_task_gatdemo-server.rendered}"
}

resource "aws_ecs_service" "ecs_service_gatdemo-elk" {
  name            = "ecs-gatdemo-elk"
  cluster         = "${aws_ecs_cluster.ecs.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task_gatdemo-elk.arn}"
  desired_count   = 1
}

resource "aws_ecs_task_definition" "ecs_task_gatdemo-elk" {
  family                = "gatdemo-elk"
  container_definitions = "${template_file.ecs_task_gatdemo-elk.rendered}"
}