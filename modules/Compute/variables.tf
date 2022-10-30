variable "workspace" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "keypair" {
  type = string
}

variable "compute_sg_id" {
  type = string
}

variable "redhat_ami" {
  type = string
}

variable "ubuntu_ami" {
  type = string
}


variable "public_subnet_1_id" {
  type = string
}
