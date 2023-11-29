---
comments: true
---
# Service Principal

```bash
az account set -s CSE-SE-DevOps
```

```bash
az group create -n myusername-tfstate-RG -l canadacentral
az storage account create -n myusernamesaccount -g myusername-tfstate-RG -l canadacentral --sku Standard_LRS
az storage container create -n myusernametfstate --account-name myusernamesaccount --auth-mode login
```

```bash
gh secret set AZURE_STORAGE_ACCOUNT_NAME -b "myusernamesaccount"
gh secret set TFSTATE_CONTAINER_NAME -b "myusernametfstate"
gh secret set AZURE_RESOURCE_GROUP_NAME -b "myusername-tfstate-RG"
```

```bash
az account list --query "[?name=='CSE-SE-DevOps'].id" --output tsv
az ad sp create-for-rbac --name "myapp" --role contributor --scopes /subscriptions/{subscription-id} --json-auth > creds.json
```

```bash
gh secret set ARM_SUBSCRIPTION_ID -b "`jq -r .subscriptionId creds.json`"
gh secret set ARM_TENANT_ID -b "`jq -r .tenantId creds.json`"
gh secret set ARM_CLIENT_ID -b "`jq -r .clientId creds.json`"
gh secret set ARM_CLIENT_SECRET -b "`jq -r .clientSecret creds.json`"
gh secret set AZURE_CREDENTIALS -b "`jq -c . creds.json`"
gh variable set DEPLOYED -b "true"
```
