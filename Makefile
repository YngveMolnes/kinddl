.PHONY: create-cluster apply-deployment wait-for-db connect-db run-script setup-all teardown

POD_NAME = $(shell kubectl get pods -l app=postgres -o jsonpath="{.items[0].metadata.name}")
SCHEMASPY_POD_NAME = $(shell kubectl get pods -l app=schemaspy -o jsonpath="{.items[0].metadata.name}")


create-cluster:
	kind create cluster --config kind-config.yaml

apply-deployment:
	kubectl apply -f postgres-deployment.yaml
	kubectl apply -f postgres-service.yaml
	kubectl create secret generic postgres-credentials --from-literal=username=postgres --from-literal=password=development
	kubectl create configmap postgres-config --from-literal=database-name=platform_development

wait-for-db:
	@echo "Waiting for PostgreSQL to start..."
	@until kubectl exec $(POD_NAME) -- psql -U postgres -c "SELECT 1" >/dev/null 2>&1; do \
		echo "PostgreSQL is unavailable - sleeping"; \
		sleep 5; \
	done

connect-db:
	kubectl exec -it $(POD_NAME) -- psql -U postgres -d platform_development

run-script:
	kubectl cp init.sql $(POD_NAME):/init.sql
	kubectl exec -it $(POD_NAME) -- psql -U postgres -f init.sql -d platform_development

create-db:
	kubectl cp user_and_db.sql $(POD_NAME):/user_and_db.sql
	kubectl exec -it $(POD_NAME) -- psql -U postgres -f user_and_db.sql

apply-schemaspy:
	kubectl apply -f schemaspy-deployment.yaml

port-forward:
	kubectl port-forward $(SCHEMASPY_POD_NAME) 8080:80

setup-all: create-cluster apply-deployment wait-for-db create-db run-script apply-schemaspy

teardown:
	kind delete cluster