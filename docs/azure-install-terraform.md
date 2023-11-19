---
comments: true
---
# Install/Update Terraform

- [x] Create bin folder in homedir. The local/bin folder is where additional software utilities will be installed.

```bash
mkdir -p ~/.local/bin
```

- [x] [HashiCorp Terraform](https://developer.hashicorp.com/terraform)

```bash
URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | egrep -v 'rc|beta|alpha' | egrep 'linux.*amd64' | tail -1)
wget ${URL} -O ~/terraform.zip
unzip -o ~/terraform.zip -d ~/.local/bin && chmod 755 ~/.local/bin/terraform
rm ~/terraform.zip
hash -r
terraform version
```
