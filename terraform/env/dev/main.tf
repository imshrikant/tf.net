locals {
  tags = {
    environment = "dev"
    owner       = "shrikanth"
    app         = "hello-api"
  }
}

module "rg" {
  source   = "../../modules/rg"
  name     = "hello-api-dev-rg"
  location = var.location
  tags     = local.tags
}

module "storage" {
  source   = "../../modules/storage"
  name     = "hellostoragedev123"
  location = var.location
  rg_name  = module.rg.name
  tags     = local.tags
}

module "container_app" {
  source   = "../../modules/container_app"
  rg_name  = module.rg.name
  location = var.location
  app_name = var.app_name
  env_id       = azurerm_container_app_environment.main.id 
  tags     = local.tags
  container_image = var.container_image
}

resource "null_resource" "deploy_api" {
  depends_on = [module.container_app]

  provisioner "local-exec" {
    command = <<EOT
      az webapp deployment source config-zip \
      --resource-group ${module.rg.name} \
      --name ${var.app_name} \
      --src ../../../dotnet-api/published.zip
    EOT
  }
}

output "app_url" {
  value = module.container_app.url
}

