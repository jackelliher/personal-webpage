#!/bin/bash

ACR_NAME="kellihercontainers.azurecr.io"
IMAGE_NAME="frontend"
IMAGE_TAG="prod"

echo "Logging in to acr"
docker login $ACR_NAME -u $ACR_NAME -p $(az acr credential show --name $ACR_NAME --query passwords[0].value --output tsv)

echo "Building image"
docker build -t $ACR_NAME/$IMAGE_TAG
