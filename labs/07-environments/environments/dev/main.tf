resource "azurerm_resource_group" "lab" {
  name     = "rg-tfmod-${var.environment}"
  location = var.azure_region
}

resource "azurerm_virtual_network" "lab" {
  name                = "vnet-tfmod-${var.environment}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "vm" {
  name                 = "snet-vm"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = [var.subnet_cidr]
}

module "linux_vm" {
  source              = "../../modules/linux-vm"
  name                = "vm-tfmod-${var.environment}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  subnet_id           = azurerm_subnet.vm.id
  ssh_public_key      = file(pathexpand("~/.ssh/id_ed25519.pub"))
  vm_size             = var.vm_size
}
