resource "template_file" "user_data" {
  template = "${file("modules/ecs/templates/user_data.sh")}"
  vars = {
      ecs_cluster_name = "${var.cluster}"
  }
}

resource "template_file" "ecs_ecr_role_policy" {
    template = "${file("modules/ecs/templates/ecs-ecr-role-policy.json")}"
}

resource "template_file" "ecs_instance_role_policy" {
    template = "${file("modules/ecs/templates/ecs-instance-role-policy.json")}"
}

resource "template_file" "ecs_role" {
    template = "${file("modules/ecs/templates/ecs-role.json")}"
}

resource "template_file" "ecs_task" {
    template = "${file("modules/ecs/templates/ecs_task_definitions.json")}"
}


