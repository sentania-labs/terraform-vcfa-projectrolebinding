terraform {
  required_version = ">= 1.14.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 3.0.0"
    }
    vcfa = {
      source  = "vmware/vcfa"
      version = ">= 1.0.0"
    }
  }
}