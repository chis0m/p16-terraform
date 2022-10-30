variable "workspace" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "region" {
  type = string
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

}

variable "public_subnets" {
  type        = list(any)
  description = "list of public subnets"
}


variable "proxy_private_subnets" {
  type        = list(any)
  description = "List of private subnets for proxy servers"
}

variable "web_private_subnets" {
  type        = list(any)
  description = "List of private subnets for web servers"
}

variable "database_private_subnets" {
  type        = list(any)
  description = "List of private subnets for databases"
}
