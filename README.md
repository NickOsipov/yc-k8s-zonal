# Yandex Cloud Kubernetes Cluster

Инфраструктурный код на Terraform для развертывания управляемого Kubernetes кластера в Yandex Cloud.

## Описание

Данный проект содержит Terraform модули для создания:

- Managed Kubernetes кластера с одним мастер-узлом
- Группы узлов с preemptible инстансами (прерываемые виртуальные машины)
- Сетевой инфраструктуры (VPC, подсеть, группы безопасности)
- Сервисного аккаунта с необходимыми правами
- KMS ключа для шифрования данных кластера

## Требования

- Terraform >= 1.0.0
- Yandex Cloud CLI
- Аккаунт в Yandex Cloud с активированным платежным аккаунтом

## Быстрый старт

1. Клонируйте репозиторий:
```bash
git clone git@github.com:NickOsipov/yc-k8s-zonal.git
cd yc-k8s-zonal
```

2. Создайте файл с переменными `infra/terraform.tfvars`:
```hcl
config = {
  zone      = "ru-central1-b"
  token     = "your-oauth-token"
  cloud_id  = "your-cloud-id"
  folder_id = "your-folder-id"
}

cluster_name         = "k8s-cluster"
network_name         = "k8s-network"
subnet_name          = "k8s-subnet"
service_account_name = "k8s-service-account"
```

3. Инициализируйте Terraform и примените конфигурацию:
```bash
cd infra
terraform init
terraform plan
terraform apply
```

## Структура проекта

```
infra/
├── modules/
│   ├── iam/              # Модуль для создания сервисного аккаунта и ролей
│   ├── network/          # Модуль для создания сетевой инфраструктуры
│   └── k8s-cluster/      # Модуль для создания Kubernetes кластера
├── main.tf               # Основной файл конфигурации
├── variables.tf          # Определение переменных
├── outputs.tf            # Выходные значения
└── provider.tf           # Настройка провайдера
```

## Настройка после развертывания

После успешного применения конфигурации:

1. Получите конфигурацию для kubectl:
```bash
yc managed-kubernetes cluster get-credentials --id <cluster-id> --external
```

2. Проверьте подключение к кластеру:
```bash
kubectl cluster-info
kubectl get nodes
```

## Настройка доступа к кластеру

После успешного развертывания кластера необходимо настроить доступ через kubectl:

1. Установите утилиту Yandex Cloud CLI, если она еще не установлена:
```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```

2. Инициализируйте CLI и авторизуйтесь:
```bash
yc init
```

3. Получите конфигурацию для доступа к кластеру:
```bash
yc managed-kubernetes cluster get-credentials --id $(terraform output -raw cluster_id) --external
```

4. Проверьте подключение к кластеру:
```bash
kubectl cluster-info
kubectl get nodes
```

5. (Опционально) Если вы хотите использовать отдельный контекст для кластера:
```bash
# Переименовать контекст
kubectl config rename-context yc-k8s-cluster my-cluster-name

# Установить контекст по умолчанию
kubectl config use-context my-cluster-name
```

6. Проверьте текущую конфигурацию:
```bash
kubectl config get-contexts
```

### Устранение проблем с доступом

Если возникли проблемы с доступом к кластеру:

1. Проверьте статус кластера:
```bash
yc managed-kubernetes cluster list
```

2. Убедитесь, что ваш IP адрес имеет доступ к API серверу кластера:
```bash
curl -k https://$(terraform output -raw cluster_endpoint)
```

3. Проверьте корректность kubeconfig:
```bash
kubectl config view
```

## Удаление ресурсов

Для удаления всех созданных ресурсов выполните:
```bash
terraform destroy
```

## Лицензия

MIT License - см. файл [LICENSE](LICENSE)

## Автор

Ваше Имя - [Nick Osipov](https://t.me/NickOsipov)

## Поддержка

При возникновении проблем создавайте Issue в репозитории проекта.

