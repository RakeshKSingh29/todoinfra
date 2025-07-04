variable "resource_group_name" {
  description = "The name of the resource group where the public IP will be created."
  type        = string      
  
}

variable "resource_group_location" {
  description = "The location of the resource group where the public IP will be created."
  type        = string
  
}

variable "pip_name" {
  description = "The name of the public IP address."
  type        = string
  
}

