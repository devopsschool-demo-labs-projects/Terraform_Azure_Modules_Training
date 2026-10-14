terraform {
  required_version = ">= 1.15.0, < 2.0.0"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4"
    }
  }
}

provider "azapi" {}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.3"
  suffix  = ["tfmod", "10"]
}

module "rg" {
  source           = "Azure/avm-res-resources-resourcegroup/azurerm"
  version          = "0.4.0"
  name             = module.naming.resource_group.name
  location         = "eastus"
  enable_telemetry = false
}

module "vnet" {
  source           = "Azure/avm-res-network-virtualnetwork/azurerm"
  version          = "0.22.2"
  name             = "vnet-tfmod-10"
  location         = "eastus"
  parent_id        = module.rg.resource_id
  address_space    = ["10.90.0.0/16"]
  enable_telemetry = false

  subnets = {
    vm = {
      name             = "snet-vm"
      address_prefixes = ["10.90.1.0/24"]
    }
  }
}

output "resource_group_id" {
  value = module.rg.resource_id
}

output "vnet_id" {
  value = module.vnet.resource_id
}
