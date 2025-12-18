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

- name: principal name (user or group) in UPN/email format (e.g. user@domain)
- role: ProjectRole name (e.g. admin, edit, view)
- kind: Subject kind (User or Group)
EOT

  validation {
    condition     = contains(["User", "Group"], var.role.kind)
    error_message = "role.kind must be either 'User' or 'Group'."
  }

  validation {
    condition     = can(regex("^[^@]+@[^@]+$", var.role.name))
    error_message = "role.name must be in UPN/email format (e.g. user@domain)."
  }
}
