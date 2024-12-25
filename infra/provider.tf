terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  zone      = var.config.zone
  folder_id = var.config.folder_id
  token     = var.config.token
  cloud_id  = var.config.cloud_id
} 