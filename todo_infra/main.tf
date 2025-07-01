module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  for_each                = var.resource_group
  resource_group_name     = each.value.resource_group_name
  resource_group_location = each.value.resource_group_location

}

module "virtual_network" {
  depends_on              = [module.resource_group]
  source                  = "../modules/azurerm_vnet"
  for_each                = var.virtual_network
  resource_group_name     = each.value.resource_group_name
  vnet_name               = each.value.vnet_name
  address_space           = each.value.address_space
  resource_group_location = each.value.resource_group_location

}

module "subnet" {
  depends_on          = [module.virtual_network]
  for_each            = var.subnet
  source              = "../modules/azurerm_subnet"
  resource_group_name = each.value.resource_group_name
  vnet_name           = each.value.vnet_name
  subnet_name         = each.value.subnet_name
  address_prefixes    = each.value.address_prefixes
}

# module "backend_subnet" {
#   #depends_on          = [module.virtual_network]
#   source              = "../modules/azurerm_subnet"
#   resource_group_name = module.resource_group.resource_group_name
#   vnet_name           = module.virtual_network.vnet_name
#   subnet_name         = "todo-be-subnet"
#   address_prefixes    = ["10.0.2.0/24"]
# }

# module "frontend_public_ip" {
#   # depends_on              = [module.resource_group]
#   for_each= var.public_ip
#   source                  = "../modules/azurerm_public_ip"
#   resource_group_name     = module.resource_group.resource_group_name
#   resource_group_location = module.resource_group.resource_group_location
#   pip_name                = "todo-fe-pip"
# }

module "public_ip" {
  depends_on              = [module.resource_group]
  source                  = "../modules/azurerm_public_ip"
  for_each                = var.public_ip
  resource_group_name     = each.value.resource_group_name
  resource_group_location = each.value.resource_group_location
  pip_name                = each.value.pip_name

}
module "virtual_machine" {
  depends_on              = [module.subnet, module.public_ip, module.resource_group, module.key_vault_secret]
  for_each                = var.virtual_machine
  source                  = "../modules/azurerm_virtual_machine"
  resource_group_name     = each.value.resource_group_name
  resource_group_location = each.value.resource_group_location
  vm_name                 = each.value.vm_name
  nic_name                = each.value.nic_name
  vnet_name               = each.value.vnet_name
  subnet_name             = each.value.subnet_name
  pip_name                = each.value.pip_name
  vm_size                 = each.value.vm_size
  key_vault_name          = each.value.key_vault_name
  custom_data = each.value.install_nginx ? (<<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install nginx -y
    systemctl enable nginx
    systemctl start nginx
  EOT
  ) : null

}

# module "backend_virtual_machine" {
#   depends_on              = [module.frontend_subnet, module.backend_subnet, module.frontend_public_ip, module.backend_public_ip]
#   source                  = "../modules/azurerm_virtual_machine"
#   resource_group_name     = module.resource_group.resource_group_name
#   resource_group_location = module.resource_group.resource_group_location
#   vm_name                 = "todobevmci"
#   nic_name                = "todo-be-nic"
#   vnet_name               = module.virtual_network.vnet_name
#   subnet_name             = "todo-be-subnet"
#   pip_name                = "todo-be-pip"
#   vm_size                 = "Standard_B1s"
#   key_vault_name          = "newinfrakv"

# }


module "sql_server" {
  depends_on              = [module.resource_group, module.key_vault_secret]
  for_each                = var.sql_server
  source                  = "../modules/azurerm_sql_server"
  resource_group_name     = each.value.resource_group_name
  resource_group_location = each.value.resource_group_location
  sql_server_name         = each.value.sql_server_name
  key_vault_name          = each.value.key_vault_name
}



module "sql_database" {
  depends_on          = [module.sql_server]
  for_each            = var.sql_database
  source              = "../modules/azurerm_sql_db"
  sql_database_name   = each.value.sql_database_name
  sql_server_name     = each.value.sql_server_name
  resource_group_name = each.value.resource_group_name
}

module "key_vault" {
  source                  = "../modules/azuerm_key_vault"
  depends_on = [ module.resource_group ]
  for_each                = var.key_vault
  key_vault_name          = each.value.key_vault_name
  resource_group_name     = each.value.resource_group_name
  resource_group_location = each.value.resource_group_location

}

module "key_vault_secret" {

  depends_on          = [module.key_vault]
  for_each            = var.key_vault_secret
  source              = "../modules/azurerm_key_vault_secret"
  secret_name         = each.value.secret_name
  secret_value        = each.value.secret_value
  key_vault_name      = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name

}

# resource "null_resource" "wait_for_key_vault" {
#   depends_on = [module.key_vault]

#   provisioner "local-exec" {
#     #command = "cmd.exe /C timeout /T 90 /NOBREAK"
#     command = "sleep 90"    
#   }
#}