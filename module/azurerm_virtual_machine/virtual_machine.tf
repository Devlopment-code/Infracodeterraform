data "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}

resource "azurerm_linux_virtual_machine" "frontend" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [data.azurerm_network_interface.nic.id]
  size               = var.size
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
}