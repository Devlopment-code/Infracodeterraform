resource "azurerm_public_ip" "public" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
 
}