variable "provider_config" {
  type = object({
    token     = string
    zone      = string
    folder_id = string
    cloud_id  = string
  })
}

variable "cluster_name" {
  type = string
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "service_account_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "kms_key_id" {
  type = string
} 