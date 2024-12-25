# Создаем кластер Kubernetes
resource "yandex_kubernetes_cluster" "k8s_cluster" {
  name       = var.cluster_name
  network_id = var.network_id

  master {
    version = "1.28"
    zonal {
      zone      = var.provider_config.zone
      subnet_id = var.subnet_id
    }
    security_group_ids = [var.security_group_id]
    public_ip = true

    maintenance_policy {
      auto_upgrade = true
    }
  }

  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id

  release_channel = "REGULAR"

  kms_provider {
    key_id = var.kms_key_id
  }
}

# Создаем группу узлов
resource "yandex_kubernetes_node_group" "k8s_node_group" {
  cluster_id = yandex_kubernetes_cluster.k8s_cluster.id
  name       = "k8s-node-group"
  version    = "1.28"

  instance_template {
    platform_id = "standard-v2"
    

    network_interface {
      nat        = true
      subnet_ids = [var.subnet_id]
    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = var.provider_config.zone
    }
  }
} 