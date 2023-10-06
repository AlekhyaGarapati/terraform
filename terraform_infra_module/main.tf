resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge (var.common_tags, var.vpc_tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge (var.common_tags, var.gw_tags)
  
}

resource "aws_subnet" "public-subnet" {
  count = length(var.public_cidr_block)
  map_public_ip_on_launch = true
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr_block[count.index]
  availability_zone = var.azs[count.index]
  tags = merge (var.common_tags, 
  {
    Name = var.public_subnet_names[count.index]
  })
}

resource "aws_subnet" "private-subnet" {
  count = length(var.private_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidr_block[count.index]
  availability_zone = var.azs[count.index]
  tags = merge (var.common_tags, 
  {
    Name = var.private_subnet_names[count.index]
  })
}

resource "aws_subnet" "database-subnet" {
  count = length(var.database_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_cidr_block[count.index]
  availability_zone = var.azs[count.index]
  tags = merge (var.common_tags, 
  {
    Name = var.database_subnet_names[count.index]
  })
}

# Creating Route table - public
resource "aws_route_table" "public_route_table" {
vpc_id = aws_vpc.main.id
tags = merge (var.common_tags, var.public_route_table_tags )
}

# Creating Route to internet gateway
resource "aws_route" "public_route" {
route_table_id = aws_route_table.public_route_table.id
destination_cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.gw.id
depends_on = [aws_route_table.public_route_table]
}

#Association of subnet to route table
resource "aws_route_table_association" "public_association" {
count = length(var.public_cidr_block)
subnet_id = element(aws_subnet.public-subnet[*].id, count.index)
route_table_id = aws_route_table.public_route_table.id
}

# Creating Route table - private
resource "aws_route_table" "private_route_table" {
vpc_id = aws_vpc.main.id
tags = merge (var.common_tags, var.private_route_table_tags )
}

#Association of subnet to route table
resource "aws_route_table_association" "private_association" {
count = length(var.private_cidr_block)
subnet_id = element(aws_subnet.private-subnet[*].id, count.index)
route_table_id = aws_route_table.private_route_table.id
}

# Creating Route table - database
resource "aws_route_table" "database_route_table" {
vpc_id = aws_vpc.main.id
tags = merge (var.common_tags, var.database_route_table_tags )
}

#Association of subnet to route table
resource "aws_route_table_association" "database_association" {
count = length(var.database_cidr_block)
subnet_id = element(aws_subnet.database-subnet[*].id, count.index)
route_table_id = aws_route_table.database_route_table.id
}