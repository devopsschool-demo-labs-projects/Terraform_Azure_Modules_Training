output "rg_name" {
  value = module.rg.name
}

output "redacted_demo" {
  description = "Sensitive is redacted in normal output, NOT encrypted in state."
  value       = module.secret_example.value
  sensitive   = true
}
