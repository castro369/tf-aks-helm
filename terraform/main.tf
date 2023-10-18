# Random suffix to create unique named resources
resource "random_id" "suffix" {
  byte_length = 4
}

# Creates specific Resource Group for the deployment
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}

# Creates the main Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "main_cluster" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myexample"

  default_node_pool {
    name       = var.aks_node_pool_name
    node_count = 1
    vm_size    = var.aks_node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# resource "azurerm_storage_account" "example" {
#   name                     = "sa10102023bigtimeexample"
#   resource_group_name      = data.azurerm_resource_group.existing_main_rg.name
#   location                 = data.azurerm_resource_group.existing_main_rg.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"

#   tags = {
#     environment = "dev"
#   }
# }