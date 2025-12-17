resource "kubernetes_manifest" "project_role_bindings" {
  for_each = {
    for u in var.users :
    "${u.kind}:${u.name}:${u.role}" => u
  }

  depends_on = var.depends_on

  manifest = {
    apiVersion = "authorization.cci.vmware.com/v1alpha1"
    kind       = "ProjectRoleBinding"

    metadata = {
      name      = "cci:${lower(each.value.kind)}:${each.value.name}"
      namespace = var.project_name
    }

    roleRef = {
      apiGroup = "authorization.cci.vmware.com"
      kind     = "ProjectRole"
      name     = each.value.role
    }

    subjects = [
      {
        kind = each.value.kind
        name = each.value.name
      }
    ]
  }
}
