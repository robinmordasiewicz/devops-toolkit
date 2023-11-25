---
comments: true
---
# Auto Pull Request

## Access Token

- Create a Github personal access token for auto-pull-request.yml action to trigger additional workflows.

```bash
gh secret set PAT --body "<your-personal-access-token>"
```

```yaml
--8<-- ".github/workflows/auto-pull-request.yml"
```
