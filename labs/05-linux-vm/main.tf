resource "azurerm_resource_group" "lab" {
  name     = "rg-tfmod-05"
  location = var.azure_region
}

resource "azurerm_virtual_network" "lab" {
  name                = "vnet-tfmod-05"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  address_space       = ["10.50.0.0/16"]
}

resource "azurerm_subnet" "vm" {
  name                 = "snet-vm"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.50.1.0/24"]
}

module "linux_vm" {
  source              = "./modules/linux-vm"
  name                = "vm-tfmod-05"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  subnet_id           = azurerm_subnet.vm.id
  ssh_public_key      = file(pathexpand("~/.ssh/id_ed25519.pub"))
  vm_size             = var.vm_size
}
