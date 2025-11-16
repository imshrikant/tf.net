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

module "app_service" {
  source   = "../../modules/app_service"
  name     = var.app_name
  location = var.location
  rg_name  = module.rg.name
  tags     = local.tags
}

resource "null_resource" "deploy_api" {
  depends_on = [module.app_service]

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
  value = "https://${module.app_service.url}"
}
