resource "azurerm_container_app_environment" "env" {
  name                = "${var.app_name}-env"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_container_app" "app" {
  name                         = var.app_name
  resource_group_name          = var.rg_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "api"
      image  = var.container_image // GitHub will push this or reference public
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
  }

  tags = var.tags
}

output "app_url" {
  value = azurerm_container_app.app.ingress[0].fqdn
}
