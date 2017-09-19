#!/bin/bash

yum install -y awslogs jq aws-cli
ECS_CLUSTER=${aws_ecs_cluster.ecs.name} > /etc/ecs/ecs.config"
