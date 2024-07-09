---
comments: true
---

# Azure Subscription

- Login

```bash
az login --use-device-code
```

- Check available subscriptions

```bash
az account list --query '[].name' -o tsv
```

- Set the default subscription to CSE-SE-DevOps

```bash
az account set -s CSE-SE-DevOps
```
