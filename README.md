# terraform-vcf-projectrolebinding

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 3.0.0 |
| <a name="requirement_vcfa"></a> [vcfa](#requirement\_vcfa) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.project_role_bindings](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the vRA / CCI project (used as the Kubernetes namespace) | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | List of users or groups to bind to project roles.<br/><br/>- name: principal name (user UPN or group)<br/>- role: ProjectRole name (e.g. project-admin, project-member)<br/>- kind: User or Group | <pre>list(object({<br/>    name = string<br/>    role = string<br/>    kind = string # User or Group<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_role_bindings"></a> [project\_role\_bindings](#output\_project\_role\_bindings) | Created ProjectRoleBinding resources |
<!-- END_TF_DOCS -->