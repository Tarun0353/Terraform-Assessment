Terraform AWS Naming Convention Module

To automate the implementation of the naming convention for AWS resources, we can develop a Terraform module that takes in the input variables domain, service name, and environment. The module will then generate the resource name in the format pbp-{domain}-{service_name}-{environment}.
Introduction
This Terraform module helps developers standardize the naming of AWS resources using a naming convention. The naming convention should follow the format pbp-{domain}-{service_name}-{environment} where pbp is fixed and represents that the resource was deployed by PayByPhone, the domain is a required value from a list of accepted domains (reporting|data|platform|frontend|backend), service_name is an optional alphanumeric string with no spaces, and environment is an optional value from the list of accepted environments (development|production).

Usage
To use this Terraform module, include the following code in your Terraform project:
module "aws_naming_convention" { 
source = "github.com/{username}/{repo_name}" 
domain = "reporting" 
service_name = "my_service"
 environment = "development"


The following input variables are supported:
Variable	Type	Default	Required	Description
delimiter	string	-	No	Ddelimiter to use in the output string
domain	string	n/a	Yes	Domain name to use in the output string
service_name	string	""	No	Service name = If not provided, a random string of length 8 will be generated
environment	string	""	No	Environment name = If not provided, no environment will be included in the output
output_format	string	lower	No	Case format =Options are lower, title, and upper.

This module will output the following:
Name	Description
name	The formatted name using the naming convention: pbp-{domain}-{service_name}-{environment}


EXAMPLES (BASH)

# Standard usage
module "naming_convention" {
  source       = "github.com/your_username/terraform-naming-convention"
  domain       = "data"
  service_name = "foobar"
  environment  = "production"
  delimiter    = "_"
  case         = "upper"
}

# Usage with random service name
module "naming_convention" {
  source       = "github.com/your_username/terraform-naming-convention"
  domain       = "reporting"
  environment  = "development"
}

# Usage with default delimiter and case
module "naming_convention" {
  source       = "github.com/your_username/terraform-naming-convention"
  domain       = "platform"
  service_name = "my_service"
  environment  = "production"
}

Reference : https://developer.hashicorp.com/terraform
