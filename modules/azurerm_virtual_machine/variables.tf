variable "resource_group_name" {}
variable "resource_group_location" {}
variable "nic_name" {}

variable "vm_name" {}
variable "vm_size" {}


  
variable "subnet_name" {}
variable "vnet_name" {}
variable "pip_name" {}
variable "key_vault_name" {}
variable "custom_data" {
  type    = string
  default = null
}