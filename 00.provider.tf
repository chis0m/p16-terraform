locals {
  tags = {
    Workspace       = terraform.workspace
    Environment     = "Dev"
    Owner-Email     = "devops.chisom@gmail.com"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }
  workspace = title(terraform.workspace)
  project   = "MC"
}

provider "aws" {
  region  = var.region
  profile = "devops.chisom"
}
