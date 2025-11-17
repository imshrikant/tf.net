resource "azurerm_app_service_plan" "plan" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.rg_name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  tags = var.tags
}

output "url" {
  value = azurerm_app_service.app.default_site_hostname
}
