variable "name" {
  description = "Resource group name."
  type        = string
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
