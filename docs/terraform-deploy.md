---
comments: true
---
# Terraform Deployment

If this is the first time running terraform then it must be initialized first. The following command only needs to be run once.

!!! note "terraform folder"

    Usually terraform files are grouped into a subfolder in a repository. This example repo has a subfolder named "terraform" where you need to execute the following commands from.


```bash
terraform init
```

Deploy the infra$tructure

```bash
terraform apply
```

Optionally, avoid additional prompts.

```bash
terraform apply -auto-approve
```

Destroy the infra$tructure
