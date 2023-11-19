---
comments: true
---

# Azure Authentication

- [x] Azure Login

```bash
az login -o none
```

- [x] Check available subscriptions

```bash
az account list --query '[].name' -o tsv
```

- [x] Set the default subscription to CSE-SE-DevOps

```bash
az account set -s CSE-SE-DevOps
```

- [x] Get Azure user UUID

```bash
az ad user list --filter "mail eq '$(az account show --query user.name -o tsv)'" --query "[0].id" -o tsv
```

- Optionally, find another user ID

```bash
az ad user list --filter "mail eq 'first.last@acme.com'" --query "[].id" -o tsv
```

- [x] Verify Azure account is a member of the CSE-SE-DevOps-Contributors group

```bash
az ad group member check --group CSE-SE-DevOps-Contributors --member-id <userid>
```

- If the Azure account is not a group member, run the following command as an administrator

```bash
az ad group member add --group CSE-SE-DevOps-Contributors --member-id <userid>
```

- Optionally, list all the members of the group

```bash
az ad group member list --group CSE-SE-DevOps-Contributors
```
