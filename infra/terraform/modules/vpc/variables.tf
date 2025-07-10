variable "cidr_block" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "azs" { type = list(string) }
variable "enable_nat_gateway" { type = bool, default = true }
variable "eip_allocation_ids" { type = list(string), default = [] }
variable "tags" { type = map(string), default = {} }
variable "name" { type = string }
