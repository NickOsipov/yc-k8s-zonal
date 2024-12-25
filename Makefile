.PHONY: init plan apply destroy lint test clean

init:
	cd infra && terraform init -upgrade

plan:
	cd infra && terraform plan

apply:
	cd infra && terraform apply -auto-approve

destroy:
	cd infra && terraform destroy -auto-approve

lint:
	terraform fmt -recursive infra/

clean:
	find . -type d -name "__pycache__" -exec rm -r {} +
	find . -type d -name "*.egg-info" -exec rm -r {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name ".pytest_cache" -exec rm -r {} +
	find . -type d -name ".terraform" -exec rm -r {} + 