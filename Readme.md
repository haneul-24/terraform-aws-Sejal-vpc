# AWS VPC Terraform Module

This module provides a dynamic and scalable way to deploy a VPC with multiple subnets. It automates the creation of an Internet Gateway and Route Table associations based on whether a subnet is marked as public or private.

---

## Features

- Accepts VPC CIDR block as input from the user
- Supports creation of multiple subnets
- Allows user to specify for each subnet:
  * CIDR block
  * Availability Zone (AZ)
- Subnets can be marked as public or private
  * By default, subnets are private
- Automatically handles networking for public subnets:
  * Creates an Internet Gateway (IGW)
  * Creates a route table with internet access (0.0.0.0/0)
  * Associates public subnets with the route table
---

## Project Structure

The project is organized into a root module and a child module located in the `module/vpc` directory:

```text
terraform-own-module-vpc/
├── module/               # Core Logic (The Product)
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── version.tf
├── examples/             # The Showcase (How to use the product)
│   └── complete/
│       ├── main.tf       # Call module from this file  (source = "../../module/vpc")
│       ├── output.tf     # Root outputs for the example
│       └── README.md     # Specific documentation for this example
├── root-main.tf          # Your current test file
├── outputs.tf            # Your current root outputs
└── README.md             # Main Project Documentation
```

## Usage

```
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
      cidr_block = "10.0.2.0/24"
      availability_zone = "ap-south-1b"
      public = true 
    },     

    private_subnet1 = {
      cidr_block = "10.0.3.0/24"
      availability_zone = "ap-south-1b" 
    }
  }
}
```



   
