variable "region" {
  type        = string
  description = "The Region were resources are to be hosted"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "preferred_number_of_subnets" {
  type        = number
  description = "Number of private subnets"
}
variable "ubuntu-ami" {
  type        = string
  description = "AMI ID for the launch template"

}

variable "redhat-ami" {
  type        = string
  description = "AMI ID for the launch template"

}

variable "keypair" {
  type        = string
  description = "key pair for the instances"
}

variable "account_no" {
  type        = string
  description = "The AWS account ID"
}

variable "master-username" {
  type        = string
  description = "RDS admin username"
}

variable "master-pass" {
  type        = string
  description = "RDS master password"

}

variable "db_name" {
  type        = string
  description = "RDS database"
}
