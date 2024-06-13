resource "null_resource" "acr_image" {
  depends_on = [data.azurerm_container_registry.container-registry]
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOF
        cd ${path.module}/..
        pip install --upgrade pip
        pip install material mkdocs-awesome-pages-plugin mkdocs-git-authors-plugin mkdocs-git-committers-plugin-2 mkdocs-git-revision-date-localized-plugin mkdocs-glightbox mkdocs-material[imaging] mkdocs-minify-plugin mkdocs-monorepo-plugin mkdocs-pdf-export-plugin mkdocs-same-dir mkdocstrings[crystal,python] mkdocs-with-pdf pymdown-extensions --user
        mkdocs build -c -d site/
        echo "${data.azurerm_container_registry.container-registry.admin_password}" | docker login --username ${random_pet.admin_username.id} --password-stdin ${random_pet.admin_username.id}.azurecr.io
        docker build -t ${random_pet.admin_username.id}.azurecr.io/docs:latest .
        docker push ${random_pet.admin_username.id}.azurecr.io/docs:latest
    EOF
  }
}

resource "azurerm_container_group" "container" {
  depends_on          = [null_resource.acr_image]
  name                = random_pet.admin_username.id
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  location            = azurerm_resource_group.azure_resource_group.location
  ip_address_type     = "Public"
  os_type             = "Linux"
  dns_name_label      = random_pet.admin_username.id
  restart_policy      = "Always"
  image_registry_credential {
    username = random_pet.admin_username.id
    password = data.azurerm_container_registry.container-registry.admin_password
    server   = "${random_pet.admin_username.id}.azurecr.io"
  }

  container {
    name   = random_pet.admin_username.id
    image  = "${random_pet.admin_username.id}.azurecr.io/docs:latest"
    cpu    = 1
    memory = 2

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

#resource "null_resource" "container-restart" {
#  depends_on = [ azurerm_container_group.container ]
#  triggers = {
#    always_run = "${timestamp()}"
#  }
#  provisioner "local-exec" {
#    command = <<EOF
#        az container restart --name ${random_pet.admin_username.id} --resource-group ${random_pet.admin_username.id}
#    EOF
#  }
#}
