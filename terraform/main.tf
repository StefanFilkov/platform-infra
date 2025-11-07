resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-dns"


  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
  }

  default_node_pool {
    name                = "systemnp"
    vm_size             = var.node_vm_size
    node_count          = var.node_count
    type                = "VirtualMachineScaleSets"
    auto_scaling_enabled = false
    os_sku               = "AzureLinux"
  }

  sku_tier = "Free" 

  role_based_access_control_enabled = true

  tags = {
    env   = var.env
    owner = var.owner
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "platform-acr-12" 
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"      
  admin_enabled       = false            
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}