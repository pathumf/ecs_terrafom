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

resource "template_file" "ecs_task_perf-client" {
    template = "${file("modules/ecs/templates/perf-client.json")}"
    vars = {
        CARBON_HOST = "${var.CARBON_HOST}"
        APP_HOST    = "${var.APP_HOST}"
    }
}

resource "template_file" "ecs_task_gatdemo-server" {
    template = "${file("modules/ecs/templates/perf-server.json")}"
}


resource "template_file" "ecs_task_gatdemo-elk" {
    template = "${file("modules/ecs/templates/elk.json")}"
    vars = {
        ELASTICSEARCH_URL = "${var.ELASTICSEARCH_URL}"
        ES_PORT = "${var.ES_PORT}"
        XPACK_MONITORING_ELASTICSEARCH_URL = "${var.ELASTICSEARCH_URL}"
    }
}


