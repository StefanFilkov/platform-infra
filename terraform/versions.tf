terraform {
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
  subscription_id = "149cc217-ad3f-4a22-bf88-3dfe3cd0adbb"
  tenant_id       = "eb3dd099-79e5-4d82-a66e-6b1f6b5c686d"
}
