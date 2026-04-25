output "vpc" {
  value = module.VPC.vpc-id
}

output "public_subnets" {
  value = module.VPC.public-subnets
}

output "private_subnets" {
  value = module.VPC.private-subnets
}