variable "AWS_REGION" {
    default = "ap-southeast-2"
}

variable "aws_vpc" {
    default = "vpc-65c4f40c"
}

variable "env" {
    default = "perf"
}

variable "cluster_name" {
    default = "perf-test"
}

variable "iam_instance_profile_id" {
    default  = ""
}

variable "key_name" {
    default = ""
}

variable "aws_ami" {
    default = ""
}

variable "instance_type" {
    default = ""
}

variable "max_size" {
    default = ""
}

variable "min_size" {
    default = ""
}

variable "desired_capacity" {
    default = ""
}

variable "private_subnet_ids" {
  type        = "list"
}

variable "load_balancers" {
  type        = "list"
  default     = []
}

variable "public_subnet_ids" {
  type        = "list"
}

variable "ecr_bucket_name" {
    default = ""
}

variable "ecr_repo_name" {
    default = ""
}