output "project_role_binding" {
  description = "Created ProjectRoleBinding manifest"
  value       = kubernetes_manifest.this.manifest
}
