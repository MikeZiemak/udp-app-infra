provider "aws" {
  region = var.AWS_REGION
}

resource "aws_vpc" "main" {
  cidr_block = var.VPC_CIDR
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.PUBLIC_SUBNET_CIDR
  map_public_ip_on_launch = true
  availability_zone       = var.PUBLIC_SUBNET_AZ
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PRIVATE_SUBNET_CIDR
  availability_zone = var.PRIVATE_SUBNET_AZ
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "server" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "udp"
    cidr_blocks = [aws_subnet.private.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "server-sg"
  }
}
