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


## Summarize
- IP Address, Subnets, CIDR Notation, IP Routing, Internet Gateways, NAT
- OSI Model, TCP/IP and how they are connected

### Assume Role Policy and Role Policy

#### Role Policy
- A permanent attachment of a role to a user

#### Assumed Role
- Obeys the law of least privileges
Use Cases
- If the root user wants a user or a resource to only access other resources with least privilege and for limited a limited amount of time (15mins to 2hrs)
- If you have users from external network that want to access your resource.
Implementation
- Create an IAM user
- Create the role R1 which the iam user will assume
    - Edit the Trust Relationship and add the arn of the iam user that will assume the role
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
              "AWS": "arn of the iam user"
            }
        }
    ]
}
```  
- Create a policy STS which will enable the user to assume the role R1
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn-of-R1"
        }
    ]
}
```  
- 
- The user will call the assume role api to assume the role. This api will give secret-key, access-key id and session-token
  
  

