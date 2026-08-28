create-cluster:
	@kind create cluster --config=cluster.yaml

load-images:
	@docker build -t vote:1.0 ./vote \
	&& docker build -t result:1.0 ./result \
	&& docker build -t worker:1.0 ./worker \
	&& docker build -t seed-data:1.0 ./seed-data

	@kind load docker-image vote:1.0 result:1.0 worker:1.0 --name cluster-apps


deploy-apps:
	@kubectl create -f k8s-specifications/

configure-kyverno:
	@helm install kyverno ./kyverno-chart/kyverno -n kyverno --create-namespace
	@kubectl apply -f kyverno-policies/
	
delete-cluster:
	@kind delete clusters cluster-apps

setup:create-cluster load-images configure-kyverno deploy-apps
	

	