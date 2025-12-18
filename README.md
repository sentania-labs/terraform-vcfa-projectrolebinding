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
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the vRA / CCI project (used as the Kubernetes namespace) | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | Single project role binding definition.<br/><br/>- name: principal name (user or group) in UPN/email format (e.g. user@domain)<br/>- role: ProjectRole name (e.g. admin, edit, view)<br/>- kind: Subject kind (User or Group) | <pre>object({<br/>    name = string<br/>    role = string<br/>    kind = string # User or Group<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_role_binding"></a> [project\_role\_binding](#output\_project\_role\_binding) | Created ProjectRoleBinding manifest |
<!-- END_TF_DOCS -->