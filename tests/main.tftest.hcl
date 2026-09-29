# Minimal terraform test experiment for terraform 1.15.x

variables {
  project_name = "test-project"
}

run "test_user_binding" {
  module {
    source = "."

    project_name = var.project_name

    role = {
      name = "alice@corp.local"
      role = "project-admin"
      kind = "User"
    }
  }

  assert {
    condition     = module.binding.manifest.metadata.name != ""
    error_message = "Manifest should have a name"
  }
}
