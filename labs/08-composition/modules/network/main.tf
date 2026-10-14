resource "azurerm_resource_group" "this" {
  name     = "rg-${var.project}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.project}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.88.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "snet-vm"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.88.1.0/24"]
}
