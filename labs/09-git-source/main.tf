terraform {
  required_version = ">= 1.15.0, < 2.0.0"
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=0.4.3"
  suffix = ["tfmod", "git"]
}

output "example_resource_group_name" {
  value = module.naming.resource_group.name
}
