variable "name" {
  description = "The display name for the security group."
  type        = string
}

variable "description" {
  description = "The group's description."
  type        = string
}

variable "owners" {
  description = "List of user principals to be assigned ownership of the group."
  type        = list(string)
}

variable "members" {
  description = "List of user principals to be assigned membership within the group."
  type        = list(string)
}

variable "enterprise_application_name" {
  description = "Name of the Azure Enterprise Application to assign the group to. Defaults to NREL Stratus AWS SSO."
  type        = string
  default     = "NREL Stratus AWS SSO"
}

variable "enterprise_app_sync_job_id" {
  description = "The ID of the synchronization job to invoke to provision user and group associations"
  type        = string
  default     = "aWSSingleSignon.a0f29d7e28cd4f5484427885aee7c080.17e6874e-3ef0-4415-86d0-e6b92e594b70"
}

variable "enterprise_app_sync_job_rule_id" {
  description = "The ID of the rule within the given sync job to evaluate principal app associations."
  type        = string
  default     = "03f7d90d-bf71-41b1-bda6-aaf0ddbee5d8"
}