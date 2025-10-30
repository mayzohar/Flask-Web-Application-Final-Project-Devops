resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc_for_project_1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    
    tags = {
        Name = "Public Subnet For Project 1"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/cluster/my-eks-cluster-for-project-1" = "shared"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc_for_project_1.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false

    tags = {
        Name = "Private Subnet For Project 1"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/my-eks-cluster-for-project-1" = "shared"
    }
}

