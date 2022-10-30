variable "workspace" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "account_no" {
  type = string
}

variable "database_private_subnet_1_id" {
  type = string
}

variable "database_private_subnet_2_id" {
  type = string
}

variable "database_sg_id" {
  type = string
}
