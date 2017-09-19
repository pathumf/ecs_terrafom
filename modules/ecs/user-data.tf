data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"
}

data "template_file" "ecs_ecr_role_policy" {
    template = ${file("${path.module}/templates/ecs-ecr-role-policy.json")}"
}

data "template_file" "ecs-instance-role-policy" {
    template = ${file("${path.module}/templates/ecs-instance-role-policy.json")}"
}

data "template_file" "ecs_role" {
    template = ${file("${path.module}/templates/ecs-role.json")}"
}

data "template_file "ecs_task" {
    template = ${file{path.module}/template/ecs_task_definitions.json}
}


