variable "vpc_cidr" {
  type = "string"
  description = "CIDR for the VPC"
}

variable "public_subnet_cidrs" {
  type = "list"
  description = "CIDRs for the public subnets"
}

variable "private_subnet_cidrs" {
  type = "list"
  description = "CIDRs for the private subnets"
}

variable "gateway_id" {
  type = string
  description = "Gateway to exit to internet"
}