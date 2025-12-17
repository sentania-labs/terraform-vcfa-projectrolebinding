output "project_role_bindings" {
  description = "Created ProjectRoleBinding resources"
  value = {
    for k, v in kubernetes_manifest.project_role_bindings :
    k => v.manifest
  }
}
