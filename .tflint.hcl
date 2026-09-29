# .tflint.hcl — Terraform lint rules for this module.
# These rules match what the CI workflow enforces at a higher level
# (format check, init, validate) but catch drift early locally.

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

config {
  # Enable deep checking of variable usage and types.
  variable_type_check = true
}
