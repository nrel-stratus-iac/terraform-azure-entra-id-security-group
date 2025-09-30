run "basic_validation" {

  module {
    source = "./tests/basic"
  }

  command = plan

  assert {
    condition     = module.azure_security_group.display_name != null
    error_message = "Invalid group display name"
  }

}


run "group_created" {

  module {
    source = "./tests/basic"
  }

  command = apply

  assert {
    condition     = module.azure_security_group.group_id != null
    error_message = "Invalid group ID"
  }

  assert {
    condition     = module.azure_security_group.provisionment.id != null
    error_message = "Invalid provisioning"
  }
}