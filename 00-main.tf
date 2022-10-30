
# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge({ "Name" = "${local.project}-${local.workspace}-VPC" }, local.tags)
}

module "VPC" {
  source                      = "./modules/VPC"
  tags                        = local.tags
  workspace                   = terraform.workspace
  project                     = local.project
  region                      = var.region
  vpc_cidr                    = var.vpc_cidr
  enable_dns_support          = var.enable_dns_support
  enable_dns_hostnames        = var.enable_dns_hostnames
  preferred_number_of_subnets = var.preferred_number_of_subnets
  public_subnets              = [for i in range(1, 3, 1) : cidrsubnet(var.vpc_cidr, 8, i)]
  proxy_private_subnets       = [for i in range(3, 5, 1) : cidrsubnet(var.vpc_cidr, 8, i)]
  web_private_subnets         = [for i in range(5, 7, 1) : cidrsubnet(var.vpc_cidr, 8, i)]
  database_private_subnets    = [for i in range(7, 9, 1) : cidrsubnet(var.vpc_cidr, 8, i)]
}


module "SecurityGroups" {
  source    = "./modules/SecurityGroups"
  tags      = local.tags
  workspace = terraform.workspace
  project   = local.project
  vpc_id    = module.VPC.vpc_id
}

module "ALB" {
  source                  = "./modules/ALB"
  tags                    = local.tags
  workspace               = terraform.workspace
  project                 = local.project
  vpc_id                  = module.VPC.vpc_id
  public_subnet_1_id      = module.VPC.public_subnet_1_id
  public_subnet_2_id      = module.VPC.public_subnet_2_id
  web_private_subnet_1_id = module.VPC.web-server-private_1_id
  web_private_subnet_2_id = module.VPC.web-server-private_2_id
  external_alb_sg_id      = module.SecurityGroups.external_alb_sg_id
  internal_alb_sg_id      = module.SecurityGroups.internal_alb_sg_id
}


module "Autoscaling" {
  source = "./modules/Autoscaling"

  tags                             = local.tags
  workspace                        = terraform.workspace
  project                          = local.project
  ubuntu-ami                       = var.ubuntu-ami
  redhat-ami                       = var.redhat-ami
  bastion_sg_id                    = module.SecurityGroups.bastion_sg_id
  proxy_server_sg_id               = module.SecurityGroups.proxy_server_sg_id
  web_server_sg_id                 = module.SecurityGroups.web_server_sg_id
  keypair                          = var.keypair
  instance_profile_id              = module.VPC.instance_profile_id
  public_subnet_1_id               = module.VPC.public_subnet_1_id
  public_subnet_2_id               = module.VPC.public_subnet_2_id
  proxy_server_private_subnet_1_id = module.VPC.proxy-server-private_1_id
  proxy_server_private_subnet_2_id = module.VPC.proxy-server-private_2_id
  web_private_subnet_1_id          = module.VPC.web-server-private_1_id
  web_private_subnet_2_id          = module.VPC.web-server-private_2_id
  wordpress_tg_arn                 = module.ALB.wordpress_tg_arn
  proxy_server_tg_arn              = module.ALB.proxy_server_tg_arn
  tooling_tg_arn                   = module.ALB.tooling_tg_arn
}

module "RDS" {
  source = "./modules/RDS"

  tags                         = local.tags
  workspace                    = terraform.workspace
  project                      = local.project
  db-name                      = var.db_name
  master-username              = var.master-username
  master-pass                  = var.master-pass
  database_private_subnet_1_id = module.VPC.database_private_subnet_1_id
  database_private_subnet_2_id = module.VPC.database_private_subnet_2_id
  database_sg_id               = module.SecurityGroups.database_server_sg_id
}

module "EFS" {
  source = "./modules/EFS"

  tags                         = local.tags
  workspace                    = terraform.workspace
  project                      = local.project
  account_no                   = var.account_no
  database_private_subnet_1_id = module.VPC.database_private_subnet_1_id
  database_private_subnet_2_id = module.VPC.database_private_subnet_2_id
  database_sg_id               = module.SecurityGroups.database_server_sg_id
}

module "Compute" {
  source = "./modules/Compute"

  tags               = local.tags
  workspace          = terraform.workspace
  project            = local.project
  keypair            = var.keypair
  redhat_ami         = var.redhat-ami
  ubuntu_ami         = var.ubuntu-ami
  public_subnet_1_id = module.VPC.public_subnet_1_id
  compute_sg_id      = module.SecurityGroups.external_alb_sg_id
}
