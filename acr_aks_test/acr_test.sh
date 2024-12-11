#!/bin/bash

# Variables
ACR_NAME="acnprd00"
RESOURCE_GROUP="acn-product-dev-eastus01-rg"
IMAGE_NAME="optimus-sample-app"
IMAGE_TAG="v1.0"
DOCKERFILE_PATH="./Dockerfile"
LOCAL_BUILD_DIR="."

# Authenticate with Azure
echo "Logging into Azure..."
az login --output none

# Retrieve the ACR login server
echo "Fetching the ACR login server..."
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query "loginServer" -o tsv)

if [ -z "$ACR_LOGIN_SERVER" ]; then
  echo "Error: Could not retrieve ACR login server. Check if ACR $ACR_NAME exists."
  exit 1
fi

# Log in to the ACR
echo "Logging into ACR..."
az acr login --name $ACR_NAME

if [ $? -ne 0 ]; then
  echo "Error: Failed to log in to ACR $ACR_NAME."
  exit 1
fi

# Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKERFILE_PATH $LOCAL_BUILD_DIR

if [ $? -ne 0 ]; then
  echo "Error: Failed to build the Docker image."
  exit 1
fi

# Tag the Docker image for ACR
echo "Tagging the Docker image for ACR..."
docker tag $IMAGE_NAME:$IMAGE_TAG $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG

# Push the image to ACR
echo "Pushing the image to ACR..."
docker push $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG

if [ $? -eq 0 ]; then
  echo "Docker image pushed successfully to $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG"
else
  echo "Error: Failed to push the Docker image to ACR."
  exit 1
fi

# Confirm completion
echo "Docker image build and upload process completed."
