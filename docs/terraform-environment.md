---
comments: true
---
# Environment Variables

Create a copy of the example vars file, without the "example" extension.

```bash
cp terraform.auto.tfvars.example terraform.auto.tfvars
```

## Example terraform.auto.tfvars

Modify the value of the `resource_group`. Choose a unique value.

```hcl
--8<-- "terraform/terraform.auto.tfvars.example"
```
