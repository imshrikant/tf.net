resource "azurerm_container_app_environment" "env" {
  name                = "${var.app_name}-env"
  resource_group_name = var.rg_name
  location            = var.location

  tags = var.tags
}

resource "azurerm_container_app" "app" {
  name                         = var.app_name
  container_app_environment_id = var.env_id
  resource_group_name          = var.rg_name

  revision_mode = "Single"

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      latest_revision = true
      percentage      = 100
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