#!/bin/bash

# Define variables
ACR_NAME="kellihercontainers"
IMAGE_NAME="frontend"
VERSION="latest"  # Change this to your desired version/tag

echo SCRIPT_DIR=$(dirname "$(realpath "$_")")
cd $_
pwd

# Build the Docker container
docker build -t $IMAGE_NAME "$($_)/../"

# Tag the Docker container with ACR login server and version
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv | tr -d '\r')
docker tag $IMAGE_NAME $ACR_LOGIN_SERVER/$IMAGE_NAME:$VERSION

# Authenticate Docker with ACR
az acr login --name $ACR_NAME

# Push the Docker container to ACR
docker push $ACR_LOGIN_SERVER/$IMAGE_NAME:$VERSION

# Check if the push was successful
if [ $? -eq 0 ]; then
    echo "Docker container pushed to Azure Container Registry successfully."
else
    echo "Error: Docker container push to Azure Container Registry failed."
fi
