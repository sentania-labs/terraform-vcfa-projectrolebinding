locals {
  subject_parts = split("@", var.role.name)
}

resource "kubernetes_manifest" "this" {
  manifest = {
    apiVersion = "authorization.cci.vmware.com/v1alpha1"
    kind       = "ProjectRoleBinding"

    metadata = {
      name      = "cci:${lower(var.role.kind)}:${local.subject_parts[1]}:${local.subject_parts[0]}"
      namespace = var.project_name
    }

    roleRef = {
      apiGroup = "authorization.cci.vmware.com"
      kind     = "ProjectRole"
      name     = var.role.role
    }

    subjects = [
      {
        kind = var.role.kind
        name = var.role.name
      }
    ]
  }
}
