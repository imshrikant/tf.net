resource "azurerm_container_app" "app" {
  name                = var.app_name
  resource_group_name = var.rg_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  location            = var.location

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      weight = 100
    }
  }

  template {
    container {
      name   = var.app_name
      image  = var.container_image
      cpu    = 0.5
      memory = "1Gi"
    }
  }

  tags = var.tags
}
