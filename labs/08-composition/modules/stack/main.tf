module "network" {
  source   = "../network"
  project  = var.project
  location = var.location
}

module "linux_vm" {
  source              = "../linux-vm"
  name                = "vm-${var.project}"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  subnet_id           = module.network.subnet_id
  ssh_public_key      = var.ssh_public_key
}
