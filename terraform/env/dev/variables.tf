variable "location" {
  default = "eastus"
}

variable "app_name" {
  default = "hello-api-dev"
}

variable "container_image" {
  type    = string
  default = "mcr.microsoft.com/dotnet/samples:aspnetapp"
}
