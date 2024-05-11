terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "nginx-api-proxy"
  location = "centralus"
}

resource "azurerm_container_app_environment" "env" {
  name                = "cae-${azurerm_resource_group.this.name}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_container_app" "proxy" {
  name                         = "ca-${azurerm_resource_group.this.name}"
  resource_group_name          = azurerm_resource_group.this.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "proxy"
      image  = "nginx:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }

    min_replicas = 1
    max_replicas = 1
  }

  ingress {
    target_port      = 80
    external_enabled = true

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}