

resource "azurerm_key_vault_secret" "username" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}

# resource "azurerm_key_vault_secret" "password" {
#   name         = "vm-password"
#   value        = "Devopsuser@1234"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

  
