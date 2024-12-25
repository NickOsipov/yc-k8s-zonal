from invoke import task
import os

@task
def init(ctx):
    """Инициализация проекта"""
    print("Initializing Terraform...")
    with ctx.cd("infra"):
        ctx.run("terraform init")

@task
def validate(ctx):
    """Проверка конфигурации Terraform"""
    print("Validating Terraform configuration...")
    with ctx.cd("infra"):
        ctx.run("terraform fmt -check")
        ctx.run("terraform validate")

@task
def plan(ctx):
    """Планирование изменений Terraform"""
    print("Planning Terraform changes...")
    with ctx.cd("infra"):
        ctx.run("terraform plan")

@task
def apply(ctx):
    """Применение конфигурации Terraform"""
    print("Applying Terraform configuration...")
    with ctx.cd("infra"):
        ctx.run("terraform apply -auto-approve")

@task
def clean(ctx):
    """Очистка временных файлов"""
    print("Cleaning temporary files...")
    patterns = [
        "__pycache__",
        "*.pyc",
        "*.pyo",
        "*.pyd",
        ".pytest_cache",
        ".coverage",
        ".terraform",
        "*.tfstate",
        "*.tfstate.backup"
    ]
    for pattern in patterns:
        ctx.run(f'find . -type f -name "{pattern}" -delete')
