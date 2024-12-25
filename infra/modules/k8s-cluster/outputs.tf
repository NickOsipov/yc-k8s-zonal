output "cluster_id" {
  value = yandex_kubernetes_cluster.k8s_cluster.id
}

output "cluster_endpoint" {
  value = yandex_kubernetes_cluster.k8s_cluster.master[0].external_v4_endpoint
} 