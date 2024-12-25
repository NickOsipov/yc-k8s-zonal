variable "provider_config" {
  type = object({
    zone      = string
    token     = string
    folder_id = string
    cloud_id  = string
  })
}

variable "service_account_name" {
  type = string
}