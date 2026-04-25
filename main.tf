resource "aws_vpc" "my-vpc-module" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    "Name" = var.vpc_config.name 
  }
}

resource "aws_subnet" "main" {
  vpc_id =aws_vpc.my-vpc-module.id
  for_each = var.subnet_config 
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = each.key
  }
}

locals {
  public-subnet = {
    for key, config in var.subnet_config: key => config if config.public
  }

  private-subnet = {
    for key, config in var.subnet_config: key => config if !config.public
  } 
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.my-vpc-module.id
  count = length(local.public-subnet) > 0 ? 1 : 0
}

resource "aws_route_table" "main" {
  count = length(local.public-subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.my-vpc-module.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
}


resource "aws_route_table_association" "main" {
  for_each = local.public-subnet

  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}

 



