resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "dev-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-vpc-ig"
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "example" {
  depends_on = [aws_internet_gateway.gw]

  allocation_id = aws_eip.eip.id
  subnet_id     = element(var.availability_zones,0)

  tags = {
    Name = "dev-vpc-nat"
  }
}

# public-subnets
resource "aws_subnet" "public-subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_cidr_blocks,count.index)
  availability_zone = element(var.availability_zones,count.index)

  tags = {
    Name = "public-${element(var.availability_zones,count.index)}"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-rt-association" {
  count             = length(var.availability_zones)
  subnet_id         = aws_subnet.public-subnets[count.index].id
  route_table_id    = aws_route_table.public-rt.id
}




# Private-subnets
resource "aws_subnet" "private-subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_cidr_blocks,count.index)
  availability_zone = element(var.availability_zones,count.index)

  tags = {
    Name = "private-${element(var.availability_zones,count.index)}"
  }
}
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0"
    nat_gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-association" {
  count             = length(var.availability_zones)
  subnet_id      = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.private-rt.id
}


# db
resource "aws_subnet" "db-subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.db_cidr_blocks,count.index)
  availability_zone = element(var.availability_zones,count.index)

  tags = {
    Name = "db-${element(var.availability_zones,count.index)}"
  }
}

resource "aws_route_table" "db-rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "db-rt"
  }
}

resource "aws_route_table_association" "db-rt-association" {
  count             = length(var.availability_zones)
  subnet_id         = aws_subnet.db-subnets[count.index].id
  route_table_id    = aws_route_table.db-rt.id
}


