# .tflint.hcl — Terraform lint rules for this module.
# Matches what the CI workflow enforces (format check, init, validate).

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}
