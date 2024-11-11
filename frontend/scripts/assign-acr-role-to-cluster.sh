#!/bin/bash

AKS_RESOURCE_GROUP=kelliher_group
AKS_CLUSTER_NAME=kellihercluster
ACR_RESOURCE_GROUP=kelliher_group
ACR_NAME=kellihercontainers

# Get the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "identityProfile.kubeletidentity.objectId" --output tsv)

# Get the ACR registry resource id
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

echo $CLIENT_ID
echo $ACR_ID

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID
