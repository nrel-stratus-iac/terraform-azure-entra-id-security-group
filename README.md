# Azure Entra ID Security Group Terraform Module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread.stratus"></a> [azuread.stratus](#provider\_azuread.stratus) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.enterprise_application_group_assignment](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) | resource |
| [azuread_group.azure_security_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_synchronization_job_provision_on_demand.group_provision_on_demand](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/synchronization_job_provision_on_demand) | resource |
| [azuread_application.group_enterprise_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_group.stratus_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.app_service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.group_member_principals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azuread_user.group_owner_principals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The group's description. | `string` | n/a | yes |
| <a name="input_enterprise_app_sync_job_id"></a> [enterprise\_app\_sync\_job\_id](#input\_enterprise\_app\_sync\_job\_id) | The ID of the synchronization job to invoke to provision user and group associations | `string` | `"aWSSingleSignon.a0f29d7e28cd4f5484427885aee7c080.17e6874e-3ef0-4415-86d0-e6b92e594b70"` | no |
| <a name="input_enterprise_app_sync_job_rule_id"></a> [enterprise\_app\_sync\_job\_rule\_id](#input\_enterprise\_app\_sync\_job\_rule\_id) | The ID of the rule within the given sync job to evaluate principal app associations. | `string` | `"03f7d90d-bf71-41b1-bda6-aaf0ddbee5d8"` | no |
| <a name="input_enterprise_application_name"></a> [enterprise\_application\_name](#input\_enterprise\_application\_name) | Name of the Azure Enterprise Application to assign the group to. Defaults to NREL Stratus AWS SSO. | `string` | `"NREL Stratus AWS SSO"` | no |
| <a name="input_members"></a> [members](#input\_members) | List of user principals to be assigned membership within the group. | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The display name for the security group. | `string` | n/a | yes |
| <a name="input_owners"></a> [owners](#input\_owners) | List of user principals to be assigned ownership of the group. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Azure AD group. |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The object ID of the Azure AD group. |
