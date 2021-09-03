# terraform-cloud-agent
A project to customize the Terraform agent container.  Changes made to this Dockerfile will trigger an Actions workflow to build and push the image to Docker Hub on the latest tag.

## Deploying to Kubernetes
The most straight forward path into k8s would be to just apply the deployment.yaml with kubectl.<br>
```
kubectl create namespace terraform-agents

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: terraform-agents
  namespace: terraform-agents
spec:
  replicas: 2
  selector:
    matchLabels:
      app: terraform-agents
  template:
    metadata:
      labels:
        app: terraform-agents
    spec:
      containers:
      - name: terraform-agents
        image: johndvs/terraform-cloud-agents:latest
        env:
        - name: TFC_AGENT_NAME
          value: "self-hosted"
        - name: TFC_AGENT_TOKEN
          value: "12345"
EOF
```
