# VPC
resource "aws_vpc" "food-1-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "food-1-vpc"
  }
}