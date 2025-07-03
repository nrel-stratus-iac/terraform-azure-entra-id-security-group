data "azuread_application" "group_enterprise_app" {
  provider     = azuread.stratus
  display_name = var.enterprise_application_name
}

data "azuread_service_principal" "app_service_principal" {
  provider     = azuread.stratus
  display_name = var.enterprise_application_name
}

data "azuread_group" "stratus_admins" {
  provider     = azuread.stratus
  display_name = "Stratus Azure Admins"
}


locals {
  group_owner_principals  = toset(var.owners)
  group_member_principals = toset(var.members)
}

data "azuread_user" "group_owner_principals" {
  for_each            = local.group_owner_principals
  provider            = azuread.stratus
  user_principal_name = each.value
}

data "azuread_user" "group_member_principals" {
  for_each            = local.group_member_principals
  provider            = azuread.stratus
  user_principal_name = each.value
}

locals {
  group_member_principal_ids = [
    for member in local.group_member_principals :
    data.azuread_user.group_member_principals[member].object_id
  ]

  group_owner_principal_ids = [
    for owner in local.group_owner_principals :
    data.azuread_user.group_owner_principals[owner].object_id
  ]
}

locals {
  service_principal_id = data.azuread_service_principal.app_service_principal.object_id
  app_role_id = [
    for role in data.azuread_application.group_enterprise_app.app_roles : role.id if role.display_name == "User"
  ][0]

  group_owners = concat(
    [local.service_principal_id],
    local.group_owner_principal_ids,
    data.azuread_group.stratus_admins.members
  )

}


resource "azuread_group" "azure_security_group" {
  provider                = azuread.stratus
  display_name            = var.name
  description             = var.description
  owners                  = local.group_owners
  members                 = local.group_member_principal_ids
  security_enabled        = true
  prevent_duplicate_names = true
}

resource "azuread_app_role_assignment" "enterprise_application_group_assignment" {
  depends_on = [azuread_group.azure_security_group]
  provider   = azuread.stratus

  app_role_id         = local.app_role_id
  principal_object_id = resource.azuread_group.azure_security_group.object_id
  resource_object_id  = local.service_principal_id
}


resource "azuread_synchronization_job_provision_on_demand" "group_provision_on_demand" {
  depends_on = [azuread_app_role_assignment.enterprise_application_group_assignment]
  provider   = azuread.stratus

  service_principal_id   = data.azuread_service_principal.app_service_principal.id
  synchronization_job_id = "/servicePrincipals/${local.service_principal_id}/synchronization/jobs/${var.enterprise_app_sync_job_id}"

  parameter {
    rule_id = var.enterprise_app_sync_job_rule_id
    subject {
      object_id        = resource.azuread_group.azure_security_group.object_id
      object_type_name = "Group"
    }
  }
}