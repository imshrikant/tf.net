terraform {
  backend "azurerm" {
    resource_group_name  = "integrator_resource_group"
    storage_account_name = "tfnet"
    container_name       = "tfnetblobcontainer"
    key                  = "dev.terraform.tfstate"
  }
}
