variable "aws_region" {
    default = ""
}

variable "aws_vpc" {
    default = ""
}

variable "env" {
    default = ""
}

variable "cluster" {
    default = ""
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

variable "ecr_repo_name" {
    default = ""
}

variable "target_group" {
    default = ""
}

variable "health_check_path" {
    default = ""
}

variable "vpc_subnets_id" {
    type = "list"
}