module "project_role_bindings" {
  source = "../"

  project_name = var.project_name

  users = [
    {
      name = "vcf-admins@corp.local"
      role = "project-admin"
      kind = "Group"
    },
    {
      name = "cloud-ops@corp.local"
      role = "project-member"
      kind = "Group"
    },
    {
      name = "scott@corp.local"
      role = "project-viewer"
      kind = "User"
    }
  ]
}
