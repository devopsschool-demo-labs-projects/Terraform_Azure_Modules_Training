moved {
  from = azurerm_resource_group.lab
  to   = module.rg.azurerm_resource_group.this
}
