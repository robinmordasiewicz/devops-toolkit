#!/bin/bash
#

# Set the default subscription.
az account set -s CSE-SE-DevOps

USERNAME=$(az ad signed-in-user show -o json | jq -r '.mail | split("@")[0]')
SUBSCRIPTIONID=$(az account list --query "[?name=='CSE-SE-DevOps'].id" --output tsv)

# Create an Azure Resource group to store the Terraform state.
#az group create -n "${USERNAME}-tfstate-RG" -l canadacentral
#az storage account create -n "${USERNAME}account" -g "${USERNAME}-tfstate-RG" -l canadacentral --sku Standard_LRS
#az storage container create -n "${USERNAME}tfstate" --account-name "${USERNAME}account" --auth-mode login

# Create a service principal
#az ad sp create-for-rbac --role Contributor --scopes "/subscriptions/${SUBSCRIPTIONID}" --json-auth > creds.json

# Create GitHub secrets.
gh auth login
gh secret set AZURE_STORAGE_ACCOUNT_NAME -b "${USERNAME}account"
gh secret set TFSTATE_CONTAINER_NAME -b "${USERNAME}tfstate"
gh secret set AZURE_RESOURCE_GROUP_NAME -b "${USERNAME}-tfstate-RG"
gh secret set ARM_SUBSCRIPTION_ID -b "`jq -r .subscriptionId creds.json`"
gh secret set ARM_TENANT_ID -b "`jq -r .tenantId creds.json`"
gh secret set ARM_CLIENT_ID -b "`jq -r .clientId creds.json`"
gh secret set ARM_CLIENT_SECRET -b "`jq -r .clientSecret creds.json`"
gh secret set AZURE_CREDENTIALS -b "`jq -c . creds.json`"
