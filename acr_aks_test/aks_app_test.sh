#!/bin/bash

# Variables
SUBSCRIPTION_ID="12302488-c84e-40e3-b782-3f748417b5fb"
TENANT_ID="b5db11ac-8f37-4109-a146-5d7a302f5881"
RESOURCE_GROUP="acn-product-dev-eastus01-rg"
AKS_CLUSTER_NAME="acn-aks-dev-01"
ACR_NAME="acnprd00"
IMAGE_NAME="optimus-hello-world"
IMAGE_TAG="v1.0"
NAMESPACE="default"
DEPLOYMENT_NAME="optimus-hello-world-app"

# Set the Azure subscription
echo "Az Login..."
az login --tenant $TENANT_ID
echo "Setting the Azure subscription..."
az account set --subscription $SUBSCRIPTION_ID 
if [ $? -ne 0 ]; then
  echo "Error: Unable to set subscription."
  exit 1
fi

# Download AKS cluster credentials
echo "Downloading AKS cluster credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --overwrite-existing 
if [ $? -ne 0 ]; then
  echo "Error: Failed to get AKS credentials."
  exit 1
fi

# # Authenticate using kubelogin
# echo "Authenticating with kubelogin..."
# kubelogin convert-kubeconfig -l azurecli
# if [ $? -ne 0 ]; then
#   echo "Error: Failed to authenticate using kubelogin."
#   exit 1
# fi

# Create a Kubernetes deployment manifest
echo "Creating deployment manifest..."
cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $DEPLOYMENT_NAME
  namespace: $NAMESPACE
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $DEPLOYMENT_NAME
  template:
    metadata:
      labels:
        app: $DEPLOYMENT_NAME
    spec:
      containers:
      - name: $IMAGE_NAME
        image: $ACR_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_TAG
        ports:
        - containerPort: 5000
---
apiVersion: v1
kind: Service
metadata:
  name: $DEPLOYMENT_NAME
  namespace: $NAMESPACE
spec:
  selector:
    app: $DEPLOYMENT_NAME
  ports:
  - protocol: TCP
    port: 80
    targetPort: 5000
  type: LoadBalancer
EOF

# Apply the deployment
echo "Deploying the application to AKS..."
kubectl apply -f deployment.yaml
if [ $? -ne 0 ]; then
  echo "Error: Failed to deploy the application."
  exit 1
fi

# Confirm deployment
echo "Deployment initiated. Run the following command to check the service's external IP:"
echo "kubectl get services -n $NAMESPACE"
