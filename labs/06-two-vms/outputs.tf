output "vm_names" {
  value = [module.app.vm_name, module.worker.vm_name]
}

output "private_ips" {
  value = [module.app.private_ip, module.worker.private_ip]
}
