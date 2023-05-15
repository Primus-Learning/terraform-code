 #create vpc
resource "aws_vpc" "MyVpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "MyVpc"
    Environment = var.env
    description = " this vpc belongs to the dev team "
  }
}
# public subnet
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.MyVpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

# private subnet
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.MyVpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subnet2"
  }
}
#internet gateway
resource "aws_internet_gateway" "myIG" {
  vpc_id = aws_vpc.MyVpc.id

  tags = {
    Name = "myIG"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIG.id
  }



  tags = {
    Name = "devRoute"
  }
}

#route table association 
resource "aws_route_table_association" "rtasso" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT.id
}

# Nat Gateway 
resource "aws_nat_gateway" "Ngateway" {
  allocation_id = aws_eip.elip.id
  subnet_id     = aws_subnet.subnet2.id

  tags = {
    Name = "gw NAT"
  }
}

#elastic ip create
resource "aws_eip" "elip" {
  vpc = true
}
# route table for the nat
resource "aws_route_table" "RT2" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Ngateway.id
  }



  tags = {
    Name = "NatroutRoute"
    Environment = "dev"
  }
}

#route table association 
resource "aws_route_table_association" "rtassont" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT2.id
}
