variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group where the SQL Server will be created."
  type        = string
}


variable "key_vault_name" {
  description = "The name of the Key Vault where secrets are stored."
  type        = string
  
}