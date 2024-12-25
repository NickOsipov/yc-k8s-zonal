# Объявление провайдера
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  token     = var.provider_config.token
  zone      = var.provider_config.zone
  folder_id = var.provider_config.folder_id
  cloud_id  = var.provider_config.cloud_id
}