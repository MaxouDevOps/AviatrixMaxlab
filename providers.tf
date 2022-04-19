# Configure Aviatrix provider
provider "aviatrix" {
  controller_ip           = "52.47.84.66"
  username                = "admin"
  password                = var.ctrl_password
  
}



provider "aws" {
    region = "eu-west-3"
}

provider "azurerm" {
  features {
    
  }
}

