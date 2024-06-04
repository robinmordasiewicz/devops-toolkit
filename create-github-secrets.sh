#!/bin/bash
#

DEPLOYED="true"
PROJECTNAME="xpertshandsonlabs"

az login --use-device-code
gh auth login
# Set the default subscription.
az account set -s CSE-SE-DevOps

USERNAME=$(az ad signed-in-user show -o json | jq -r '.mail | split("@")[0]')
SUBSCRIPTIONID=$(az account list --query "[?name=='CSE-SE-DevOps'].id" --output tsv)

# Create an Azure Resource group to store the Terraform state.
az group create -n "${PROJECTNAME}-tfstate-RG" -l eastus
az storage account create -n "${PROJECTNAME}account" -g "${PROJECTNAME}-tfstate-RG" -l eastus --sku Standard_LRS
az storage container create -n "${PROJECTNAME}tfstate" --account-name "${PROJECTNAME}account" --auth-mode login

# Create a service principal
#az ad sp create-for-rbac --name ${PROJECTNAME} --role Contributor --role acrpush --scopes "/subscriptions/${SUBSCRIPTIONID}" --json-auth > creds.json
az ad sp create-for-rbac --name ${PROJECTNAME} --role Contributor --scopes "/subscriptions/${SUBSCRIPTIONID}" --json-auth > creds.json
#az role assignment create --scope "/subscriptions/${SUBSCRIPTIONID}" --role acrpull --assignee "$(jq -r .clientId creds.json)"

# Create GitHub secrets.
gh secret set AZURE_STORAGE_ACCOUNT_NAME -b "${PROJECTNAME}account"
gh secret set TFSTATE_CONTAINER_NAME -b "${PROJECTNAME}tfstate"
gh secret set AZURE_RESOURCE_GROUP_NAME -b "${PROJECTNAME}-tfstate-RG"
gh secret set ARM_SUBSCRIPTION_ID -b "$(jq -r .subscriptionId creds.json)"
gh secret set ARM_TENANT_ID -b "$(jq -r .tenantId creds.json)"
gh secret set ARM_CLIENT_ID -b "$(jq -r .clientId creds.json)"
gh secret set ARM_CLIENT_SECRET -b "$(jq -r .clientSecret creds.json)"
gh secret set AZURE_CREDENTIALS -b "$(jq -c . creds.json)"
gh secret set PROJECTNAME -b "${PROJECTNAME}"
