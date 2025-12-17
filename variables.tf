variable "project_name" {
  type        = string
  description = "Name of the vRA / CCI project (used as the Kubernetes namespace)"
}

variable "users" {
  type = list(object({
    name = string
    role = string
    kind = string # User or Group
  }))

  description = <<EOT
List of users or groups to bind to project roles.

- name: principal name (user UPN or group)
- role: ProjectRole name (e.g. project-admin, project-member)
- kind: User or Group
EOT

  validation {
    condition     = alltrue([for u in var.users : contains(["User", "Group"], u.kind)])
    error_message = "users.kind must be either 'User' or 'Group'."
  }
}
