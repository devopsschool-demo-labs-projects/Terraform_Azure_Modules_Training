variable "rg_name" {
  type    = string
  default = "rg-tfmod-11"

  validation {
    condition     = startswith(var.rg_name, "rg-")
    error_message = "The resource group name must start with rg-."
  }
}
