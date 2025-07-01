terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "350e4500-bc54-46c6-9b0a-7ca946c56838"
  # Configuration options
}

