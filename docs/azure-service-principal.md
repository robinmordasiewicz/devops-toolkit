---
comments: true
---
# Service Principal

- Set the default subscription.

```bash
az account set -s CSE-SE-DevOps
```

- Create an Azure Resource group to store the Terraform state.

```bash
az group create -n myusername-tfstate-RG -l canadacentral
az storage account create -n myusernameaccount -g myusername-tfstate-RG -l canadacentral --sku Standard_LRS
az storage container create -n myusernametfstate --account-name myusernameaccount --auth-mode login
```

- Authenticate with a GitHub.com account.

```bash
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
gh auth login
```

- Create GitHub secrets.

```bash
gh secret set AZURE_STORAGE_ACCOUNT_NAME -b "myusernameaccount"
gh secret set TFSTATE_CONTAINER_NAME -b "myusernametfstate"
gh secret set AZURE_RESOURCE_GROUP_NAME -b "myusername-tfstate-RG"
```

- Create a service principal.

```bash
az account list --query "[?name=='CSE-SE-DevOps'].id" --output tsv
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/{subscription-id} --json-auth > creds.json
```

- Create GitHub secrets.

```bash
gh secret set ARM_SUBSCRIPTION_ID -b "`jq -r .subscriptionId creds.json`"
gh secret set ARM_TENANT_ID -b "`jq -r .tenantId creds.json`"
gh secret set ARM_CLIENT_ID -b "`jq -r .clientId creds.json`"
gh secret set ARM_CLIENT_SECRET -b "`jq -r .clientSecret creds.json`"
gh secret set AZURE_CREDENTIALS -b "`jq -c . creds.json`"
```

- Manually create a workflow variable using the Github UI, named `DEPLOYED`, with a value of `true`.
- Manually execute the terraform workflow, and watch job progress and resoure creation in the Azure portal.
- Modify cloud-init file and commmit, observe the auto-pull-request workflow, and then approve the pull request. Watch the job progress and resource creation in the Azure portal. Notice that the VM is re-created and initialized with the new cloud-init file.
- Toggle the DEPLOYED variable to false and manually trigger the terraform workflow. Watch the job progress and resource deletion in the Azure portal.
