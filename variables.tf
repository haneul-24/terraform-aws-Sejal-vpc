variable "vpc_config" {
  description = "To get the vaule of cidr and name in VPC"
  type = object({
    cidr_block = string 
    name = string 
  })
  validation {
     condition = can(cidrnetmask(var.vpc_config.cidr_block))
     error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
   }
}


variable "subnet_config" {
  # subnet1 = {cidr= .. azs = ..}
  # key     =   value in object (is value ke andar multiple fields hai.)
  description = "To get the CIDR and AZ of subnet"
  type = map(object({
    cidr_block = string 
    availability_zone = string 
    public = optional(bool, false)
  }))

  validation {
    condition = alltrue([for config in var.subnet_config: can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format!!"
  }
} 

