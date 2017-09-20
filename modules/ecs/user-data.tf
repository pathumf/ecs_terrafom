data "template_file" "user_data" {
  template = "${file("../templates/user_data.sh")}"
  vars = {
      ecs_cluster_name = "${var.cluster}"
  }
}

data "template_file" "ecs_ecr_role_policy" {
    template = "${file("../templates/ecs-ecr-role-policy.json")}"
}

data "template_file" "ecs_instance_role_policy" {
    template = "${file("../templates/ecs-instance-role-policy.json")}"
}

data "template_file" "ecs_role" {
    template = "${file("../templates/ecs-role.json")}"
}

data "template_file "ecs_task" {
    template = "${file("../template/ecs_task_definitions.json")}"
}


