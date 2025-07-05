data "azurerm_subnet" "data_import" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_network_interface" "nic_vm" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ip_name
    subnet_id                     = data.azurerm_subnet.data_import.id
    private_ip_address_allocation = "Dynamic"
  }
}