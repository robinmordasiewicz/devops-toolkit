---
comments: true
---

# Azure Subscription

- [x] Check available subscriptions

```bash
az account list --query '[].name' -o tsv
```

- [x] Set the default subscription to CSE-SE-DevOps

```bash
az account set -s CSE-SE-DevOps
```
