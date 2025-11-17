resource "azurerm_container_app_environment" "env" {
  name                = "${var.app_name}-env"
  location            = var.location
  resource_group_name = var.rg_name

  tags = var.tags
}

resource "azurerm_container_app" "app" {
  name                         = var.app_name
  resource_group_name          = var.rg_name
  location                     = var.location
  container_app_environment_id = azurerm_container_app_environment.env.id

  revision_mode = "Single"

  ingress {
    external_enabled = true
    target_port      = 80

    traffic {
      percentage = 100
      latest_revision = true
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
