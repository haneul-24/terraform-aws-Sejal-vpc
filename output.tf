 
locals {
  public-subnet-output =  {
    for key, config in local.public-subnet: key => {
      subnet-id = aws_subnet.main[key].id
      az = aws_subnet.main[key].availability_zone
    }
  }

  private-subnet-output = {
    for key, config in local.private-subnet: key => {
      subnet-id = aws_subnet.main[key].id
      az = aws_subnet.main[key].availability_zone
    }
  }
}

output "vpc-id" {
  value = aws_vpc.my-vpc-module.id
}

output "public-subnets" {
  value = local.public-subnet-output
}

output "private-subnets" {
  value = local.private-subnet-output
}