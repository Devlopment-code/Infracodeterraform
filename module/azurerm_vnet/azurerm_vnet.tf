resource "azurerm_virtual_network" "vnet" {
  name                = var.todo_vnet
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space   
  } 