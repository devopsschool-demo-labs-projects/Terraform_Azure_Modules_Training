variable "rg_name" {
  type = string

  validation {
    condition     = startswith(var.rg_name, "rg-")
    error_message = "The resource group name must start with rg-."
  }
}

variable "azure_region" {
  type    = string
  default = "eastus"
}

variable "training_secret" {
  description = "Disposable demo-only text; never use a real password."
  type        = string
  sensitive   = true
}
