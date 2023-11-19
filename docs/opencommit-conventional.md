---
comments: true
---
# OpenCommit Conventional

To install OpenCommit, run the following command in your terminal:

```bash
npm install --global opencommit
```

## Configure OpenCommit

To configure OpenCommit to use the conventional commits style, you need to create a `.opencommitrc` file in your project root. Add the following content to the file:

```json
{
  "type": "conventional"
}
```

## Use OpenCommit

To use OpenCommit, run the following command in your terminal:

```bash
opencommit
```

This will open an interactive prompt that will guide you through the commit process.

## Verify Configuration

To verify that OpenCommit is configured correctly, make a commit. The commit message should follow the conventional commits style.

## Troubleshoot Issues

If you encounter any issues, refer to the [OpenCommit documentation](https://github.com/okonet/opencommit).
