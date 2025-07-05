module "resource_group" {
    source = "../module/azurerm_resource_group"
    rg_name = "rg_todoapp"
    location = "CentralIndia"
}
  

module "vnet_1" {
 depends_on = [ module.resource_group ]
    source = "../module/azurerm_vnet"
    todo_vnet = "todo_vnet"
    rg_name = "rg_todoapp"
    location = "CentralIndia"
    address_space = ["10.0.0.0/26"]
}

module "frontend_subnet" {
    depends_on = [ module.vnet_1 ]
    source = "../module/azurerm_subnet"
    subnet_name = "frontend_subnet"
    rg_name = "rg_todoapp"
    vnet_name = "todo_vnet"
    address_prefixes = ["10.0.0.0/27"]
}
module "backend_subnet" {
    depends_on = [ module.vnet_1 ]
    source = "../module/azurerm_subnet"
    subnet_name = "backend_subnet"
    rg_name = "rg_todoapp"
    vnet_name = "todo_vnet"
    address_prefixes = ["10.0.0.32/27"]
}
    module "pip" {
    source = "../module/pip"
    pip_name = "pip_frontend"
    location = "CentralIndia"
    rg_name = "rg_todoapp"
    allocation_method = "Static"
    }
module "pip1" {
    source = "../module/pip"
    pip_name = "pip_backend"
    location = "CentralIndia"
    rg_name = "rg_todoapp"
    allocation_method = "Static"
    }

module "azurerm_network_interface_backend12" {
    depends_on = [ module.pip1]
    source = "../module/azurerm_nic"
    nic_name = "nic_vm_frontend"
    location = "CentralIndia"
    rg_name = "rg_todoapp"
    ip_name = "ipconfig1"
    # subnet_id =  "/subscriptions/ff2c3052-bd08-443f-80dd-1cabe7cbcd50/resourceGroups/rg_todoapp/providers/Microsoft.Network/virtualNetworks/todo_vnet/subnets/frontend_subnet"
    vnet_name = "todo_vnet"
    subnet_name = "frontend_subnet"
    
    }
    module "azurerm_network_interface_frontend" {
    depends_on = [ module.pip ]
    source = "../module/azurerm_nic"
    nic_name = "nic_vm_frontend"
    location = "CentralIndia"
    rg_name = "rg_todoapp"
    ip_name = "ipconfig1"
    # subnet_id =  "/subscriptions/ff2c3052-bd08-443f-80dd-1cabe7cbcd50/resourceGroups/rg_todoapp/providers/Microsoft.Network/virtualNetworks/todo_vnet/subnets/frontend_subnet"
    vnet_name = "todo_vnet"
    subnet_name = "frontend_subnet"
    
    }

module "vm_frontend" {
    depends_on = [ module.azurerm_network_interface_frontend ]
   source = "../module/azurerm_virtual_machine"
   vm_name = "vmfrontend"
    location = "CentralIndia"
    rg_name = "rg_todoapp"
    # nic_id = "/subscriptions/ff2c3052-bd08-443f-80dd-1cabe7cbcd50/resourceGroups/rg_todoapp/providers/Microsoft.Network/networkInterfaces/nic_vm_frontend"
    size = "Standard_D2s_v3"
    nic_name = "nic_vm_frontend"
    admin_username = "adminuser1"
    admin_password = "P@ssw0rd@123"
    publisher = "Canonical"
    offer = "0001-com-ubuntu-confidential-vm-jammy"
    sku = "22_04-lts-cvm"
    storage_account_type = "Standard_LRS"
}