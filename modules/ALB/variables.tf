variable "workspace" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}

variable "web_private_subnet_1_id" {
  type = string
}

variable "web_private_subnet_2_id" {
  type = string
}


variable "external_alb_sg_id" {
  type = string
}

variable "internal_alb_sg_id" {
  type = string
}
