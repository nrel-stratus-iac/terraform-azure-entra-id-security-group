provider "azuread" {
  alias = "stratus"
}

module "azure_security_group" {
  source = "./../.."
  providers = {
    azuread.stratus = azuread.stratus
  }
  name        = "csccloud-tfc-module-test-group-DELETE-ME"
  description = "TFC module test group"
  members     = ["itester@nrel.gov"]
  owners      = ["itester@nrel.gov"]
}