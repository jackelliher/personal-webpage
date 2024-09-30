provider "azurerm" {
  features {}
  use_msi = true
  subscription_id = "7b82a276-2c62-4467-bbae-6dbfc14b221"
  tenant_id       = "6063b581-feca-4503-9afe-eff6cde6456b"
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }
}

