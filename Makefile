create-cluster:
	@kind create cluster --config=cluster.yaml

deploy-apps:
	@kubectl create -f k8s-specifications/

install-kyverno:
	@helm install kyverno ./kyverno-chart/kyverno -n kyverno --create-namespace

delete-cluster:
	@kind delete cluster


	