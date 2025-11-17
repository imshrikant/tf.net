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
  source          = "../../modules/container_app"
  rg_name         = module.rg.name
  location        = var.location
  app_name        = var.app_name
  tags            = local.tags
  container_image = var.container_image
}

# (OPTIONAL) — Only needed if you want to update Container App image via CLI
resource "null_resource" "update_image" {
  depends_on = [module.container_app]

  provisioner "local-exec" {
    command = <<-EOT
      az containerapp update \
        --name ${var.app_name} \
        --resource-group ${module.rg.name} \
        --image ${var.container_image}
    EOT
  }
}

output "app_name" {
  value = module.container_app.app_name
}
