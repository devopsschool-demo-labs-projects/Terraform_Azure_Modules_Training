module "rg" {
  source   = "./modules/resource-group"
  name     = var.rg_name
  location = var.azure_region
}

module "secret_example" {
  source = "./modules/secret-example"
  value  = var.training_secret
}
