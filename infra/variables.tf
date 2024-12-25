variable "config" {
  type = object({
    token     = string
    zone      = string
    folder_id = string
    cloud_id  = string
  })
  description = "Yandex Cloud configuration"
}

variable "network_name" {
  description = "Имя VPC сети"
  type        = string
  default     = "k8s-network"
}

variable "subnet_name" {
  description = "Имя подсети"
  type        = string
  default     = "k8s-subnet"
}

variable "cluster_name" {
  description = "Имя кластера Kubernetes"
  type        = string
  default     = "k8s-cluster"
}

variable "service_account_name" {
  description = "Имя сервисного аккаунта"
  type        = string
  default     = "k8s-service-account"
} 