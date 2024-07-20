variable "alb_asg_vpc_cidr" {
  default     = "192.168.0.0/20"  # overridden in etc/
  description = "alb_asg_vpc_cidr block"
  type        = string
}
variable "subnetcidr" {
  default     = "192.168.0.0/20"   # overridden in etc/
  description = "alb_asg_vpc_cidr block"
  type        = string
}
resource "aws_vpc" "vpc_01" {
  cidr_block           = var.alb_asg_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "ebs-VPC"
  }
}

# Define the Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_01.id
}

resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.vpc_01.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all IP addresses (use with caution)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.vpc_01.id
  cidr_block        = var.subnetcidr
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"  # Specify the availability zone where you want the subnet
  # Add other subnet configuration as needed
}

# Create a Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.public.id
}