# Service principal used by the provider (values copied from the variables-lab project).
# Leave empty to fall back to `az login` CLI credentials instead.
variable "client_id" {
  description = "Azure service principal app ID. Empty string means use CLI auth."
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "Azure service principal secret. Empty string means use CLI auth."
  type        = string
  default     = ""
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID. Empty string means use CLI auth."
  type        = string
  default     = ""
}

variable "subscription_id" {
  description = "Azure subscription ID. Empty string means use CLI auth."
  type        = string
  default     = ""
}

# STRING - Azure region (same value as the variables-lab project)
variable "azure_region" {
  description = "Azure region for every resource in this lab."
  type        = string
  default     = "West US 3"
}

variable "vm_size" {
  description = "SKU for both Ubuntu VMs."
  type        = string
  # Standard_B2s_v2 cannot be used in this subscription: standardBsv2Family quota is 0 in West US 3.
  # StandardDdsv6Family has 20 cores of quota there, so the lab uses Standard_D2ds_v6 (2 vCPU).
  default = "Standard_D2ds_v6"
}

variable "vm_count" {
  description = "How many nginx VMs to create."
  type        = number
  default     = 2

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 5
    error_message = "vm_count must be between 1 and 5."
  }
}

variable "admin_username" {
  description = "Linux admin user created on each VM."
  type        = string
  default     = "labadmin"
}

# NUMBER/STRING inputs that flow into the nginx template - change these and the
# rendered /etc config changes too (custom_data is force-new, so VMs are replaced).
variable "nginx_port" {
  description = "Port nginx listens on and the NSG opens."
  type        = number
  default     = 80

  validation {
    condition     = var.nginx_port >= 1 && var.nginx_port <= 65535
    error_message = "nginx_port must be a valid TCP port."
  }
}

variable "nginx_site_name" {
  description = "Name of the nginx site file created from the template."
  type        = string
  default     = "terraform-lab"
}

variable "page_title" {
  description = "Heading written into the rendered index.html."
  type        = string
  default     = "Served by Terraform templates"
}
