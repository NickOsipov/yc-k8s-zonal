module "network" {
  source = "./modules/network"

  network_name    = var.network_name
  subnet_name     = var.subnet_name
  provider_config = var.config
}

module "iam" {
  source = "./modules/iam"

  provider_config      = var.config
  service_account_name = var.service_account_name
}

module "k8s_cluster" {
  source = "./modules/k8s-cluster"

  provider_config    = var.config
  cluster_name       = var.cluster_name
  network_id         = module.network.network_id
  subnet_id          = module.network.subnet_id
  security_group_id  = module.network.security_group_id
  service_account_id = module.iam.service_account_id
  kms_key_id         = module.iam.kms_key_id
}
