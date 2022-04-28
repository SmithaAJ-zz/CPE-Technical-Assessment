# Create the resource group, network interfaces and storage account to be attached to the virtual machines 

resource "azurerm_resource_group" "rg" {
  name     = "rg_test"
  location = var.location
  tags = merge(
    local.common_tags,
    map("rg_name", "rg_test")
  )
}

resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = var.location
}

resource "azurerm_network_security_group" "test" {
  name                = "test-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_virtual_network" "test" {
  name                = "test-net"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.10", "10.0.0.11"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.test.id
  }

  tags = merge(
    local.common_tags,
    map("Environment", "Test")
  )
}

resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "subnet1"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  for_each            = toset(var.virtualmachine_name)
  name                = each.value
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "admin"
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

  admin_ssh_key {
    username   = "admin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    version   = "latest"
  }

  tags = merge(local.common_tags,map(
      "Environment", "Test"
      "OSFamily", "Linux",
      "Role", "Test App VM")
  ))
}

