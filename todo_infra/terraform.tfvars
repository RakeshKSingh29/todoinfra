# Resource Group

resource_group = {
  rg1 = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
  }
    rg2 = {
    resource_group_name     = "todo-infra-rg-01"
    resource_group_location = "centralindia"
  }
}

# Virtual Network

virtual_network = {
  vnet = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
    vnet_name               = "todo-vnet"
    address_space           = ["10.0.0.0/16"]

  }
}

# Subnet 
subnet = {
  fe_subnet = {
    resource_group_name = "todo-infra-rg"
    vnet_name           = "todo-vnet"
    subnet_name         = "todo-fe-subnet"
    address_prefixes    = ["10.0.1.0/24"]
  }
  be_subnet = {
    resource_group_name = "todo-infra-rg"
    vnet_name           = "todo-vnet"
    subnet_name         = "todo-be-subnet"
    address_prefixes    = ["10.0.2.0/24"]
  }
}
# public ip 
public_ip = {
  fe_pip1 = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
    pip_name                = "frontend-pip"

  }
  fe_pip2 = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
    pip_name                = "backend-pip"

  }
}

# virtual machine
virtual_machine = {
  fe_vm = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
    vm_name                 = "todofevmci"
    nic_name                = "todo-fe-nic"
    vnet_name               = "todo-vnet"
    subnet_name             = "todo-fe-subnet"
    pip_name                = "frontend-pip"
    vm_size                 = "Standard_B1s"
    key_vault_name          = "newinfrakv"
    install_nginx           = true

  }
  be_vm = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
    vm_name                 = "todobevmci"
    nic_name                = "todo-be-nic"
    vnet_name               = "todo-vnet"
    subnet_name             = "todo-be-subnet"
    pip_name                = "backend-pip"
    vm_size                 = "Standard_B1s"
    key_vault_name          = "newinfrakv"
    install_nginx           = false
  }
}

# mssql server

sql_server = {
  sql_server = {
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"
    sql_server_name         = "todoinfrasqlserver"
    key_vault_name          = "newinfrakv"

  }
}

#sql_database

sql_database = {
  sql_database = {
    sql_database_name   = "tododb"
    sql_server_name     = "todoinfrasqlserver"
    resource_group_name = "todo-infra-rg"
  }
}

# Key vault
key_vault = {
  kv = {
    key_vault_name          = "newinfrakv"
    resource_group_name     = "todo-infra-rg"
    resource_group_location = "centralindia"

  }
}

# key_vault_secret

key_vault_secret = {
  username = {
    key_vault_name      = "newinfrakv"
    resource_group_name = "todo-infra-rg"
    secret_name         = "vm-username"
    secret_value        = "Devopsadmin"

  }
  password = {
    key_vault_name      = "newinfrakv"
    resource_group_name = "todo-infra-rg"
    secret_name         = "vm-password"
    secret_value        = "todouser@1234"

  }
}

