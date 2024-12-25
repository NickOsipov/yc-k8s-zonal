output "network_id" {
  value = yandex_vpc_network.k8s_network.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.k8s_subnet.id
}

output "security_group_id" {
  value = yandex_vpc_security_group.k8s-public-services.id
} 