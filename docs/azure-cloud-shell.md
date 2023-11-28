---
comments: true
---
# [Azure Portal Login](https://portal.azure.com)

- Launch Azure Cloud Shell from the top navigation of the Azure portal
- Click `Bash`

![Screenshot showing how to start Azure Cloud Shell in the Azure portal.](img/azure-cloud-shell.png)

!!! info "The first time you start Cloud Shell you're prompted to create an Azure Storage account for the Azure file share."

- Click `Show advanced settings`

![Select Advanced](img/azure-cloud-shell-select-storage-advanced.png)

- `Subscription`: `CSE-SE-DevOps`
- `Cloud Shell region`: `Canada Central`
- `Resource group`: `yourusername-cloudshell`
- `Storage account`: `yourusernamestorage`
!!! warning "Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only."
- `File share`: `yourusername-fileshare`

![Create Storage](img/azure-cloud-shell-select-storage-advanced-create-storage.png)
