resource "azurerm_virtual_network" "vn" {
  name                = "TF-network"
  address_space       = ["10.0.0.0/16"]
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "example" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                    = "TF-pip"
  location                = "westus2"
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "test"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "TF-nic"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.5"
    public_ip_address_id          = azurerm_public_ip.example.id
     }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "linux-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westus2"
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

data "azurerm_public_ip" "example" {
  name                = azurerm_public_ip.example.name
  resource_group_name = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.example.ip_address
}