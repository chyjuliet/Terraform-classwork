# VPC
resource "aws_vpc" "food-1-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "food-1-vpc"
  }
}

# PUBLIC SUBNET
resource "aws_subnet" "food-1-pub-sn" {
  vpc_id     = aws_vpc.food-1-vpc.id
  cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = "true"
  tags = {
    Name = "food public subnet"
  }
}

# PRIVATE SUBNET
resource "aws_subnet" "food-1-pvt-sn" {
  vpc_id     = aws_vpc.food-1-vpc.id
  cidr_block = "10.0.2.0/24"
map_public_ip_on_launch = "false"
  tags = {
    Name = "food private subnet"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "food-1-igw" {
  vpc_id = aws_vpc.food-1-vpc.id

  tags = {
    Name = "food igw"
  }
}

# PUBLIC ROUTE
resource "aws_route_table" "food-1-pub-rt" {
  vpc_id = aws_vpc.food-1-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.food-1-igw.id
  }

  tags = {
    Name = "food pub rt"
  }
}

# PRIVATE ROUTE
resource "aws_route_table" "food-1-pvt-rt" {
  vpc_id = aws_vpc.food-1-vpc.id

  tags = {
    Name = "food pvt rt"
  }
}

# SUBNET-ROUTE TABLE ASSOCIATION PUBLIC
resource "aws_route_table_association" "food-1-pub-asc" {
  subnet_id      = aws_subnet.food-1-pub-sn.id
  route_table_id = aws_route_table.food-1-pub-rt.id
}

# SUBNET-ROUTE TABLE ASSOCIATION PRIVATE
resource "aws_route_table_association" "food-1-pvt-asc" {
  subnet_id      = aws_subnet.food-1-pvt-sn.id
  route_table_id = aws_route_table.food-1-pvt-rt.id
}