# terraform-vcfa-projectrolebinding

Terraform module — assigns a user or group a role within a VCF Automation (VCFA) project using the CCI `ProjectRoleBinding` Kubernetes manifest.

## Prerequisites

- A kubernetes provider configured to target a CCI cluster that exposes the
  `authorization.cci.vmware.com` API group.
- The cluster must have the `ProjectRole` and `ProjectRoleBinding` custom resources.

## Provider setup

The module itself uses only the `kubernetes` provider (`kubernetes_manifest` resource).
The caller must configure it before invoking the module. Typical configurations:

```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"       # use default kubeconfig context
  # OR
  host        = "https://api.cci.example.com"
  token       = var.kubernetes_token
  # OR
  cluster_name = "my-cci-cluster"       # select a context from kubeconfig
}
```

## Accepted roles

The `role` argument accepts the name of an existing `ProjectRole` in the target
cluster. The convention used in this module's examples is:

| Role name        | Access level |
|------------------|--------------|
| `project-admin`  | Full project administration |
| `project-member` | Read-write access to project resources |
| `project-viewer` | Read-only access |

These names are not enforced by the module — they are a convention that matches
common VCFA CCI role definitions.

## Identity mapping

The module generates the Kubernetes resource name by splitting the principal's
UPN (user@domain) on the `@` character:

```
cci:<lower(kind)>:<local-part>:<domain-part>
```

Examples:

| UPN                   | Generated name                    |
|-----------------------|-----------------------------------|
| `alice@corp.local`    | `cci:user:alice:corp.local`       |
| `vcf-admins@corp.local` | `cci:group:vcf-admins:corp.local` |

This naming scheme makes it trivially readable which principal and kind a
binding references, and avoids collisions when the same UPN is bound to
different roles (each module invocation produces a distinct name).

## Example

A minimal runnable example:

```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "project_role_binding" {
  source = "sentania-labs/terraform-vcfa-projectrolebinding"

  project_name = "finance-prod"

  role = {
    name = "scott@corp.local"
    role = "project-viewer"
    kind = "User"
  }
}
```

See the `examples/` directory for a multi-binding `for_each` pattern that
assigns users and groups in parallel.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 3.0.0 |

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