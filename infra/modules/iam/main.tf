# Добавляем KMS ключ
resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "kms-key"
  description       = "Ключ для шифрования важной информации кластера"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год
}

# Создаем сервисный аккаунт
resource "yandex_iam_service_account" "k8s_service_account" {
  name        = var.service_account_name
  description = "Service account for Kubernetes cluster"
}

# Назначаем роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  folder_id = var.provider_config.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_service_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  folder_id = var.provider_config.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_service_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = var.provider_config.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_service_account.id}"
}

# Добавляем роль для работы с KMS
resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  folder_id = var.provider_config.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_service_account.id}"
} 