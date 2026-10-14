output "name" {
  description = "Name created by the module."
  value       = azurerm_resource_group.this.name
}

output "id" {
  description = "Azure resource group ID."
  value       = azurerm_resource_group.this.id
}
