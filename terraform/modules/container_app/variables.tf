variable "app_name" { type = string }
variable "rg_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }
variable "container_image" { type = string }
variable "env_id" {
  description = "The ID of the Azure Container App Environment"
  type        = string
  # default     = "..." # Optional: uncomment and add a default value if desired
}
