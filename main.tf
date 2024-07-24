
# Define a versão do provedor
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.112.0"
    }
  }
}

# Configura o provedor 
provider "azurerm" {
  features {}
}

# Cria um grupo de recursos
resource "azurerm_resource_group" "rg01" {
  name     = var.rg_name
  location = env.azure_region
}

# Criando um endereço de IP público
resource "azurerm_public_ip" "pub-ip01" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  allocation_method   = "Static"
}

# Criando uma rede virtual
resource "azurerm_virtual_network" "vnet01" {
  name                = var.vnet_name
  address_space       = var.address_vnet
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name
}

# Criando uma sub-rede dentro da vnet01
resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = var.address_subnet
}

# Cria um grupo de segurança de rede permitindo SSH
resource "azurerm_network_security_group" "nsg01" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  security_rule  {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Faz a associação nsg01 com a subnet01
resource "azurerm_subnet_network_security_group_association" "subnsg01" {
  subnet_id                 = azurerm_subnet.subnet01.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}

# Cria uma interface de rede que fica ligada à sub-rede e ao IP público
resource "azurerm_network_interface" "nic01" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub-ip01.id
  }
}

# Cria uma máquina virtual Linux com uma chave SSH pública, disco do sistema operacional padrão e imagem Ubuntu
resource "azurerm_linux_virtual_machine" "vm01" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  size                = var.size_vm
  admin_username      = var.name_user
  network_interface_ids = [
    azurerm_network_interface.nic01.id,
  ]

  admin_ssh_key {
    username = var.name_user
    public_key = file("arquivos/id_rsa.pub")
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

# Adiciona uma extensão à máquina virtual para execução do script
resource "azurerm_virtual_machine_extension" "vm_ext" {
  name                 = var.name_ext
  virtual_machine_id   = azurerm_linux_virtual_machine.vm01.id
  publisher            = var.pub_ext
  type                 = var.type_ext
  type_handler_version = "2.1"
  
  settings = <<SETTINGS
    {
      "script": "${filebase64("${path.module}/script.sh")}"
    }
  SETTINGS
}



