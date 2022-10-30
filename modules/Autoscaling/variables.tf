variable "workspace" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "ubuntu-ami" {
  type = string
}

variable "redhat-ami" {
  type = string
}

variable "bastion_sg_id" {
  type = string
}

variable "proxy_server_sg_id" {
  type = string
}

variable "web_server_sg_id" {
  type = string
}

variable "instance_profile_id" {
  type = string
}

variable "keypair" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}

variable "proxy_server_private_subnet_1_id" {
  type = string
}

variable "proxy_server_private_subnet_2_id" {
  type = string
}

variable "web_private_subnet_1_id" {
  type = string
}

variable "web_private_subnet_2_id" {
  type = string
}

variable "proxy_server_tg_arn" {
  type = string
}

variable "wordpress_tg_arn" {
  type = string
}

variable "tooling_tg_arn" {
  type = string
}
