terraform {
  required_version = ">= 0.14"
  required_providers {
    azuread = {
      source                = "hashicorp/azuread"
      configuration_aliases = [azuread.stratus]
    }
  }
}