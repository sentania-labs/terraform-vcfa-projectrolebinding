mock_provider "kubernetes" {}

variables {
  project_name = "test-project"
  role = {
    name = "alice@corp.local"
    role = "project-admin"
    kind = "User"
  }
}

run "user_binding" {
  command = plan

  assert {
    condition     = output.project_role_binding.metadata.name == "cci:user:corp.local:alice:project-admin"
    error_message = "Binding name should be cci:<kind>:<domain>:<local-part>:<role>"
  }

  assert {
    condition     = output.project_role_binding.metadata.namespace == "test-project"
    error_message = "Binding should be created in the project namespace"
  }

  assert {
    condition     = output.project_role_binding.subjects[0].kind == "User" && output.project_role_binding.subjects[0].name == "alice@corp.local"
    error_message = "Subject should be the principal passed in role"
  }
}

run "group_binding" {
  command = plan

  variables {
    role = {
      name = "vcf-admins@corp.local"
      role = "project-viewer"
      kind = "Group"
    }
  }

  assert {
    condition     = output.project_role_binding.metadata.name == "cci:group:corp.local:vcf-admins:project-viewer"
    error_message = "Group binding name should be cci:group:<domain>:<local-part>:<role>"
  }
}

run "same_principal_two_roles_do_not_collide" {
  command = plan

  variables {
    role = {
      name = "alice@corp.local"
      role = "project-viewer"
      kind = "User"
    }
  }

  assert {
    condition     = output.project_role_binding.metadata.name == "cci:user:corp.local:alice:project-viewer"
    error_message = "The same principal with a different role must get a different binding name"
  }
}

run "rejects_invalid_kind" {
  command = plan

  variables {
    role = {
      name = "alice@corp.local"
      role = "project-admin"
      kind = "Robot"
    }
  }

  expect_failures = [var.role]
}
