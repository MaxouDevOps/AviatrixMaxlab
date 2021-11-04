


# Build the AWS Transit 

# module "transit_aws_1" {
#   source  = "terraform-aviatrix-modules/aws-transit/aviatrix"
#   version = "v4.0.3"

#   cidr = "10.77.0.0/20"
#   region = "eu-central-1"
#   account = "Eskimoo"

#   name = "avffhub"
#   ha_gw = "false"
#   instance_size = "t2.micro"

  
#}

#  Build the AWS Spokes

# module "spoke_aws" {
#   source  = "Eskimoodigital/aws-spoke-ec2/aviatrix"
#   version = "1.0.14"

#   count = 2

#   name            = "avffsp${count.index}"
#   cidr            = var.spoke_cidrs[count.index]
#   region          = "eu-central-1"
#   account         = "Eskimoo"
#   transit_gw      = "avx-avffhub-transit"
#   vpc_subnet_size = "24"

#   ha_gw = "false"
#   instance_size = "t2.micro"

#   ec2_key = "KP_AVI_EC2_SPOKE"
# }


module "transit_azure_1" {
  source  = "terraform-aviatrix-modules/azure-transit/aviatrix"
  version = "4.0.1"

  cidr = "10.78.0.0/20"
  region = "West Europe"
  account = "EskimooAzure"

  ha_gw = "false"
  name = "avazhub"
  instance_size = "Standard_B1ms"

}


module "spoke_azure_1" {
  # source  = "terraform-aviatrix-modules/azure-spoke/aviatrix"
  # version = "4.0.1"
  source = "github.com/Eskimoodigital/Eskimoo_Tfm_Avi_Azu_Spoke_wVM"

  count = 2

  name = "avazsp${count.index}"
  cidr = var.azure_spoke_cidrs[count.index]
  region = "West Europe"
  account = "EskimooAzure"
  transit_gw = "avx-avazhub-transit"
  vnet_subnet_size = "24"
  ha_gw = "false"
  
  instance_size = "Standard_B1ms"

}
  



# module "transit-peering" {
#   source  = "terraform-aviatrix-modules/mc-transit-peering/aviatrix"
#   version = "1.0.4"

#   transit_gateways = [
#     "avx-avazhub-transit",
#     "avx-avffhub-transit",
    
#   ]

  
# }

module "vm_azure_1" {
  # source  = "terraform-aviatrix-modules/azure-spoke/aviatrix"
  # version = "4.0.1"
  source = "github.com/Eskimoodigital/module_azure_vm"

  count = 2

  name          = "vmazsp${count.index}"
  cidr          = module.spoke_azure_1[count.index].vnet.subnets[0].subnet_id
  nic_name      = "vmnic${count.index}"
  ip_name       = "vmip${count.index}"
  rg_name       = "vmrg${count.index}"
  publicip_name = "vmpip${count.index}"

  # depends_on = [
  #   module.spoke_azure_1
 # ]
}
  




# output "vnet_for_vm" {
#   value = module.spoke_azure_1[1].vnet
# }

# resource "azurerm_resource_group" "example" {
#   name     = "RGEskTfm"
#   location = "West Europe"
# }

# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name


#   ip_configuration {
#     name                          = "internal"
#     #subnet_id                     = aviatrix_vpc.default[0].subnets[2].subnet_id
#     subnet_id                     = module.spoke_azure_1[0].vnet.subnets[0].subnet_id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.example.id


#   }
# }

# resource "azurerm_public_ip" "example" {
#   name                = "EskimooPublicIp1"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location

#   allocation_method = "Dynamic"

# }


# resource "azurerm_linux_virtual_machine" "example" {
#   name                = "EskimooTest"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location

#   size                            = "Standard_F2"
#   disable_password_authentication = false
#   admin_username                  = "adminuser"
#   admin_password                  = "Password123!"
#   network_interface_ids = [
#     azurerm_network_interface.example.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }
# }
