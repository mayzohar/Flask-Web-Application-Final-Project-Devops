resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.vpc_for_project_1.id 
  tags = {
    Name = "main-internet-gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_for_project_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.main_igw]
}
