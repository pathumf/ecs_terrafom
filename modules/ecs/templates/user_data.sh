#!/bin/bash

yum install -y awslogs jq aws-cli
echo "ECS_CLUSTER=${ecs_cluster_name} > /etc/ecs/ecs.config
