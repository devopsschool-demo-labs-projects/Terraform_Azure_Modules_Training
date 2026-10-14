output "vm_names" {
  description = "Names of the Ubuntu VMs running nginx."
  value       = azurerm_linux_virtual_machine.vm[*].name
}

output "public_ip_addresses" {
  description = "Static public IP of each VM, in VM order."
  value       = azurerm_public_ip.vm[*].ip_address
}

output "nginx_urls" {
  description = "Open one of these in a browser to see the templated nginx config working."
  value = [
    for ip in azurerm_public_ip.vm[*].ip_address :
    "http://${ip}:${var.nginx_port}"
  ]
}

output "ssh_commands" {
  description = "SSH access to each VM (key auth, user set by admin_username)."
  value = [
    for ip in azurerm_public_ip.vm[*].ip_address :
    "ssh ${var.admin_username}@${ip}"
  ]
}
