### my base
// data "aws_vpc" "default" {
//   default = true
// }

// data "aws_subnets" "default" {
//   vpc_id = data.aws_vpc.default
// }
# Assiging a static public IP address to the bastion host
// resource "aws_eip" "b-h_eip" {
//   instance = aws_instance.b-h.id
//   vpc      = true
// }

############ Adding VPC 

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_id
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}

# IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_IGW"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

#Subnets Private and Public
resource "aws_subnet" "pub-snet" {
  count             = length(var.pub-snet)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.pub-snet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "pub-snet${count.index}"
  }
}

resource "aws_subnet" "priv-snet" {
  count             = 2
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.priv-snet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "priv-snet${count.index}"
  }
}

# Route Table
resource "aws_route_table" "my_main_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "my_main_rt"
  }
}

resource "aws_route_table" "my_priv_rt" {
  count  = length(var.priv-snet)
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_NATGW[count.index].id
  }


  tags = {
    Name = "my_priv_rt"
  }
}


# Private RTA
resource "aws_route_table_association" "my_priv_rta" {
  count          = length(aws_nat_gateway.my_NATGW)
  subnet_id      = aws_subnet.priv-snet[count.index].id
  route_table_id = aws_route_table.my_priv_rt[count.index].id
}

# Public RTA
resource "aws_route_table_association" "my_pub_rta" {
  count          = length(var.pub-snet)
  subnet_id      = aws_subnet.pub-snet[count.index].id
  route_table_id = aws_route_table.my_main_rt.id
}

# EIP's
resource "aws_eip" "my_eip" {
  count = 2
  vpc   = true
}

# NAT GW 
resource "aws_nat_gateway" "my_NATGW" {
  count         = length(var.pub-snet)
  allocation_id = aws_eip.my_eip[count.index].id
  subnet_id     = aws_subnet.pub-snet[count.index].id

  tags = {
    Name = "my_NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW]
}