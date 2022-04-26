# provider block so that terraform knows that its deploying azure reso1urces
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.76.0"
    }
  }
}