variable "project_name" {
  type        = string
  description = "Name of the vRA / CCI project (used as the Kubernetes namespace)"
}

variable "role" {
  type = object({
    name = string
    role = string
    kind = string # User or Group
  })

  description = <<EOT
Single project role binding definition.

- name: principal name (user UPN or group name)
- role: ProjectRole name (e.g. project-admin, project-member)
- kind: Subject kind (User or Group)
EOT

  validation {
    condition     = contains(["User", "Group"], var.role.kind)
    error_message = "role.kind must be either 'User' or 'Group'."
  }
}
