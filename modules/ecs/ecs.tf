
resource "aws_launch_configuration" "ecs_lc" {
    name_prefix     = "${var.env}_${var.cluster}-"
    mage_id             = "${var.aws_ami}"
    instance_type        = "${var.instance_type}"
    security_groups      = ["${aws_security_group.ecs_sg.id}"]
    user_data            = "${data.template_file.user_data.rendered}"
    iam_instance_profile = "${var.iam_instance_profile_id}"
    key_name             = "${var.key_name}"

    lifecycle {
    create_before_destroy = true
  }
    
}


resource "aws_autoscaling_group" "ecs_asg" {
  name                 = "${var.environment}_${var.cluster}-asg"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.ecs_lc.id}"
  vpc_zone_identifier  = ["${var.private_subnet_ids}"]
  load_balancers       = ["${var.load_balancers}"]


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
