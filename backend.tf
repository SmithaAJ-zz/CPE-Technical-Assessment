# the following block stores the tf state on local machine
terraform {
  backend "local" {
    path = "Terraform_Local/terraform.tfstate"
  }
}

# if using terraform cloud workspace 
terraform {
  backend "remote" {
    hostname     = "terraform.test.com.au"
    organization = "test"

    workspaces {
      name = "test"
    }
  }
}