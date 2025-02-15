#Create VPC
resource "aws_vpc" "customNW" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "customNW"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.customNW.id
  cidr_block = "10.0.0.0/26"
  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.customNW.id
  cidr_block = "10.0.0.64/26"
  tags = {
    Name = "Private_Subnet"
  }
}

#Create Internet Gateway and attach to VPC

resource "aws_internet_gateway" "IG_customNW" {
  tags = {
    Name = "IG_customNW"
  }
  vpc_id = aws_vpc.customNW.id
}

# Create Nat gateway

# Create Route table and Edite route

resource "aws_route_table" "RT_IG_customNW" {
  tags = {
    Name = "RT_IG_customNW"
  }
  vpc_id = aws_vpc.customNW.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG_customNW.id
  }
}

# Subnet association to route

resource "aws_route_table_association" "RT_Public_Subnet" {
  route_table_id = aws_route_table.RT_IG_customNW.id
  subnet_id      = aws_subnet.public.id
}

#Subnet associatetion for NAT gateway

#Create security group


# Create SG Group
resource "aws_security_group" "allow_tls" {
  name   = "allow_tls"
  vpc_id = aws_vpc.customNW.id
  tags = {
    Name = "customNW_SG"
  }
  dynamic "ingress" {
    for_each = [22]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      //ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

