# Provider (and credentials) copied from the variables-lab project (/Users/rajesh/training/terraform/first).
# That project's motshare/Motoshare storage account no longer exists (404), so this lab keeps
# remote state in the existing tfstatedemo123456 account instead, under its own unique key.
# Credentials come from terraform.tfvars (gitignored) or, when left empty, from `az login`.
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-demo"
    storage_account_name = "tfstatedemo123456"
    container_name       = "tfstate"
    key                  = "lab13-nginx-template.tfstate"
  }
}

provider "azurerm" {
  features {}

  client_id       = var.client_id == "" ? null : var.client_id
  client_secret   = var.client_secret == "" ? null : var.client_secret
  tenant_id       = var.tenant_id == "" ? null : var.tenant_id
  subscription_id = var.subscription_id == "" ? null : var.subscription_id
}
