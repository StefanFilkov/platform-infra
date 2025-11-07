terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatebazinga"
    container_name       = "tfstate"
    key                  = "envs/prod/terraform.tfstate"
    use_azuread_auth     = true
  }
}
