---
comments: true
---
# Cloud Shell

- [Azure Portal Login](https://portal.azure.com)
- Launch Azure Cloud Shell from the top navigation of the Azure portal
- Select Bash

![Screenshot showing how to start Azure Cloud Shell in the Azure portal.](img/azure-cloud-shell.png)

!!! info "The first time you start Cloud Shell you're prompted to create an Azure Storage account for the Azure file share."

- Select "Show advanced settings"

![Select Advanced](img/azure-cloud-shell-select-storage-advanced.png)

- Select "CSE-SE-DevOps" as the "Subscription"
- Select "Canada Central" as the "Cloud Shell region"
- Enter "<yourusername-cloudshell>" as the "Resource group"

> [!WARNING]
> Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only.

- Enter "<yourusername-fileshare>" as the "File share"

![Create Storage](img/azure-cloud-shell-select-storage-advanced-create-storage.png)
