output "group_id" {
  description = "The object ID of the Azure AD group."
  value       = azuread_group.azure_security_group.id
}

output "display_name" {
  description = "The display name of the Azure AD group."
  value       = azuread_group.azure_security_group.display_name
}