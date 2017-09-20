
module "ecs" {
    source              = "modules/ecs"
    aws_vpc             = "vpc-d8e011b1"
    env                 = "perf"
    cluster             = "perf-test"
    key_name            = "perftest"
    aws_ami             = "ami-1c002379"
    instance_type       = "t2.micro"
    max_size            = 2
    min_size            = 1
    desired_capacity    = 1
    ecr_repo_name       = "ecsperfrepo"
    target_group        = "ecstarget"
    health_check_path   = "/"
    aws_region          = "us-east-2"
    vpc_subnets_id      = ["subnet-523dc63b","subnet-4475440e","subnet-4475440e" ]

}

