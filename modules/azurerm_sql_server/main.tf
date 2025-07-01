resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.username.value
  administrator_login_password = data.azurerm_key_vault_secret.password.value
  minimum_tls_version          = "1.2"
}


output "sql_server_id" {
  value = azurerm_mssql_server.sqlserver.id
}

output "sql_server_name" {
  value = azurerm_mssql_server.sqlserver.name
  
}