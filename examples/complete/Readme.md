## Usage 
```
provider "aws" {
  region = "ap-south-1"
}

module "VPC" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "test-module-vpc"
  } 
  
  subnet_config = {
    public_subnet1 = {
      cidr_block = "10.0.1.0/24"
      availability_zone = "ap-south-1a"
      public = true 
    },

    public_subnet2 = {
      cidr_block = "10.0.3.0/24"
      availability_zone = "ap-south-1b"
      public = true 
    },

    private_subnet1 = {
      cidr_block = "10.0.2.0/24"
      availability_zone = "ap-south-1b"
    }
  }
}
```


   
