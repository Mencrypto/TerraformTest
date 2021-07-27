provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "all" {
  state = "available"
}

#Define VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "VPC192"
    Env  = "TFT"
  }
}

## Define the public subnets
resource "aws_subnet" "Public" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.all.names[count.index]
  count             = 2
  tags = {
    Name = "Public0${count.index + 1}"
    Env  = "TFT"
  }
}

## Define the private subnets
resource "aws_subnet" "Private" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.all.names[count.index]
  count             = 2
  tags = {
    Name = "Private0${count.index + 1}"
    Env  = "TFT"
  }
}

#Define routes, default route is equal to cidr of VPC
resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.custom_vpc.id
  route = []
  tags = {
    Name = "Public"
    Env  = "TFT"
  }
}

resource "aws_route_table" "Private" {
  vpc_id = aws_vpc.custom_vpc.id
  route = []
  tags = {
    Name = "Private"
    Env  = "TFT"
  }
}

#Associate subnets to route tables
resource "aws_route_table_association" "PublicAssosiation" {
  count          = length(aws_subnet.Public)
  subnet_id      = element(aws_subnet.Public.*.id, count.index)
  route_table_id = aws_route_table.Public.id
  depends_on     = [aws_route_table.Public]
}

resource "aws_route_table_association" "PrivateAssosiation" {
  count          = length(aws_subnet.Private)
  subnet_id      = element(aws_subnet.Private.*.id, count.index)
  route_table_id = aws_route_table.Private.id
  depends_on     = [aws_route_table.Private]
}

##Form to modify default route table
#resource "aws_default_route_table" "default" {
#  default_route_table_id = aws_vpc.custom_vpc.default_route_table_id

##If you have an existing IGW you should first create the VPC, then via console attach the IGW and then configure
##the internet exit route 
# route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = var.gateway_id
#  }

#  tags = {
#    Name = "Public"
#  }
#}