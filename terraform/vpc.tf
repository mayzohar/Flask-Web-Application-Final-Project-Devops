provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "vpc_for_project_1"{
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "vpc-for-project-1"
    }
}

