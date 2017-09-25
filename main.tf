
module "ecs" {
    source              = "modules/ecs"
    aws_vpc             = "vpc-d8e011b1"
    env                 = "perf"
    cluster             = "perf-test"
    key_name            = "perftest"
    aws_ami             = "ami-1c002379"
    instance_type       = "t2.large"
    max_size            = 2
    min_size            = 1
    desired_capacity    = 1
    ecr_repo_name       = "ecsperfrepo"
    target_group        = "ecstarget"
    health_check_path   = "/"
    aws_region          = "us-east-2"
    vpc_subnets_id      = ["subnet-523dc63b","subnet-4475440e","subnet-4475440e" ]
    ELASTICSEARCH_URL   = "es.perf.local"
    ES_PORT             = "9200"
    CARBON_HOST         = "shipper.perf.local"
    APP_HOST            = "app.perf.local"
    XPACK_MONITORING_ELASTICSEARCH_URL  = ${var.ELASTICSEARCH_URL}

}

