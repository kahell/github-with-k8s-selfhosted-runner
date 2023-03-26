# Description
This repository is about spawn Kubernetes using Terraform

# Integrate Kubernetes to Github

## Pre-required
1. Github Apps Private Keys files
2. Install App
## Step

### Install Jetstack:
1. `helm repo add jetstack https://charts.jetstack.io`
2. `helm repo update`
3. `helm search repo cert-manager`

### Integrate to Github 
1. Install certifcate manager
`helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.11.0 --set prometheus.enabled=false --set startupapicheck.timeout=5m --set installCRDs=true`

2. Create name-spaces of actions
`kubectl create ns actions`

3. Install secret control manager
```
kubectl create secret generic controller-manager \
-n actions \
--from-literal=github_app_id=<github_app_id> \
--from-literal=github_app_installation_id=<github_app_installation_id> \
--from-file=github_app_private_key=<github_app_private_key>
```

4. Install action controller
`helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller`

5. Helm repo update
`helm repo update`

6. Search help repo (To get version)
`helm search repo actions`

7. Install runner
```
helm install runner \
actions-runner-controller/actions-runner-controller \
--namespace actions \
--version 0.22.0 \
--set syncPeriod=1m
```

8. Check controller pod
`kubectl get pod -n actions`

9. Setup K8s yaml
```
k8s/runner-deployment.yml
k8s/horizontal-runner-autoscaler.yml
```
10. Deploy k8s yaml
```
kubectl apply -f runner-deployment.yml
kubectl apply -f horizontal-runner-autoscaler.yml
```

# Command SSH
## SSH To Cluster
`aws eks --region us-east-1 update-kubeconfig --name de-prod-cicd`
## get nodes
`kubectl get nodes -o wide`
## verify service
`kubectl get svc`
## get namespaces
`kubectl get namespaces`
## get all
`kubectl get all -n default`
## get pods
`kubectl get pods -n default`
## describe
`kubectl describe <pod-name> -n <namespace>`
## create secrets
```
kubectl create secret generic controller-manager \
-n actions \
--from-literal=github_app_id=<github_app_id> \
--from-literal=github_app_installation_id=<github_app_installation_id> \
--from-file=github_app_private_key=<github_app_private_key>
```

## get secrets
`get secret github-secrets -n actions -o jsonpath="{.data.GITHUB_AWS_ACCESS_KEY_ID}"`

## install metric-server
`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`