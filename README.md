## AUTOMATE INFRASTRUCTURE WITH IAC USING TERRAFORM PART 1

This manual implementation of this project using AWS console is at [Multi-site Project](https://github.com/chis0m/devops-pbl-projects/blob/master/p15-multiple-site-on-aws.md)

#### Initialize terraform
- in project folder create `main.tf` file
- add a provider
```terraform
provider "aws" {
  region  = var.region
  profile = "mycred" # aws credentials profile. If not specified, default will be used
}
```
- run `terraform init`

#### Install tflint
- `brew install tflint`
- in your project root create a `.tflint.hcl` and paste
```terraform
plugin "aws" {
    enabled = true
    version = "0.17.1"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
```
- run `tflint --init`

#### using variables
- create `variables.tf` file and `terraform.tfvars`
- move your variables to variables.tf
- `terraform.tfvars` is like a .env file for terraform, where you set the actual values e,g
```terraform
# variable.tf file
variable "region" {
  type    = string
}

# terraform.tfvars file
region = "eu-central-1"
```

### Tag pattern
<Project>-<Worspace><ResourceTitle><Resource>

#### Terraform Workspaces
- create two workspaces, dev and prod with the command `terraform workspace new dev`
- List workspaces  `terraform workspace list`
- Show the exact workspace `terraform workspace show`
- Switch workspace `terraform workspace select prod`

### Terrafrom CICD
Note: Let the tflint version on your local match what you have in cicd
The CICD was implemented with:
- terraform linter (tflint)
- 2 terrafrom workspaces (dev, prod)
- 2 env variables (dev, prod)
- 3 branches (develop, master, delete-develop)
- 5 github action workflows
- Setup Github branch protection rules (for the three branches)  
- Whenever a pull request(PR) is opened against any of the branches, tflint, terrafrom validate and plan is run. 
The aim is to make sure the script is valid and, the changes to be made to the infrastructure is seen.
- When the PR is merged to `develop` branch, the infrastructure is deployed to a dev environment in a different region.
- When the PR is merged into `master`, it is deployed to production environment
- When the PR is merged into `delete-develop`, the infrastructure in the dev environment is destroyed. This branch was created to manage cost.
- When deploying to `production` and `delete-develop`, a manual approval is required to complete the deployment. This is achieved through `github environment rules setting`.


  
  

