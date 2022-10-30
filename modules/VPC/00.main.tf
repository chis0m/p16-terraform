# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  subnetCount = var.preferred_number_of_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_subnets
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge({ "Name" = "${var.project}-${var.workspace}-VPC" }, var.tags)
}
