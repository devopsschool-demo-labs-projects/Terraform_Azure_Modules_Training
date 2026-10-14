locals {
  ssh_public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  nginx_doc_root = "/var/www/lab13"
  index_file     = "index.html"

  vms = [
    for i in range(var.vm_count) : {
      index    = i
      name     = "vm-tfmod-13-${format("%02d", i)}"
      hostname = "lab13vm${i}"
    }
  ]
}

resource "azurerm_resource_group" "lab" {
  name     = "rg-tfmod-13"
  location = var.azure_region
}

resource "azurerm_virtual_network" "lab" {
  name                = "vnet-tfmod-13"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  address_space       = ["10.13.0.0/16"]
}

resource "azurerm_subnet" "vm" {
  name                 = "snet-vm"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.13.1.0/24"]
}

resource "azurerm_network_security_group" "lab" {
  name                = "nsg-tfmod-13"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "AllowSSHInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # The port opened here is the same variable the nginx template listens on.
  security_rule {
    name                       = "AllowNginxInbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = tostring(var.nginx_port)
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "vm" {
  count               = var.vm_count
  name                = "pip-${local.vms[count.index].name}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vm" {
  count               = var.vm_count
  name                = "nic-${local.vms[count.index].name}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "vm" {
  count                     = var.vm_count
  network_interface_id      = azurerm_network_interface.vm[count.index].id
  network_security_group_id = azurerm_network_security_group.lab.id
}

# THE core idea of this lab: nginx is installed and configured at first boot from
# templates rendered by Terraform's templatefile() - nothing is configured by hand.
#
#   templates/nginx.conf.tftpl     -> rendered -> base64 -> written to the VM by cloud-init
#   templates/cloud-init.yaml.tftpl -> rendered -> custom_data -> executed by cloud-init
#
# custom_data is a force-new argument: changing a template or any value fed into it
# replaces the VMs so the new config is guaranteed to be applied on a clean boot.
resource "azurerm_linux_virtual_machine" "vm" {
  count                 = var.vm_count
  name                  = local.vms[count.index].name
  computer_name         = local.vms[count.index].hostname
  location              = azurerm_resource_group.lab.location
  resource_group_name   = azurerm_resource_group.lab.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm[count.index].id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = local.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-26_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(
    templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
      vm_hostname = local.vms[count.index].hostname
      page_title  = var.page_title
      nginx_port  = var.nginx_port
      doc_root    = local.nginx_doc_root
      index_file  = local.index_file
      site_name   = var.nginx_site_name

      nginx_conf_b64 = base64encode(
        templatefile("${path.module}/templates/nginx.conf.tftpl", {
          vm_hostname = local.vms[count.index].hostname
          nginx_port  = var.nginx_port
          server_name = "_"
          doc_root    = local.nginx_doc_root
          index_file  = local.index_file
        })
      )
    })
  )
}
