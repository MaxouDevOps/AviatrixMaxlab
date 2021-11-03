terraform {
  required_providers {
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
    }
    aws = {
      source = "hashicorp/aws"
      version = "3.56.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.83.0"
    }
  }
  required_version = ">= 0.13"

}


