locals {
  role_bindings = {
    for rb in [
      {
        project_name = var.project_name
        name         = "vcf-admins@corp.local"
        role         = "project-admin"
        kind         = "Group"
      },
      {
        project_name = var.project_name
        name         = "cloud-ops@corp.local"
        role         = "project-member"
        kind         = "Group"
      },
      {
        project_name = var.project_name
        name         = "scott@corp.local"
        role         = "project-viewer"
        kind         = "User"
      }
    ] :
    "${rb.project_name}:${rb.kind}:${rb.name}:${rb.role}" => rb
  }
}

module "project_role_binding" {
  for_each = local.role_bindings

  source = "../"

  project_name = each.value.project_name

  role = {
    name = each.value.name
    role = each.value.role
    kind = each.value.kind
  }
}
