variable "name" {
  description = "Resource group name."
  type        = string
  validation {
    condition     = startswith(var.name, "rg-")
    error_message = "Resource group names in this course must start with rg-."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Optional resource tags."
  type        = map(string)
  default     = { course = "terraform-modules" }
}
