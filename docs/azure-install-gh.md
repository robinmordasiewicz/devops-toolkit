---
comments: true
---
# Install/Update GitHub cli

- [x] Create bin folder in homedir. The local/bin folder is where additional software utilities will be installed.

```bash
mkdir -p ~/.local/bin
```

- [x] [GitHub CLI (gh) install](https://cli.github.com)

```bash
URL=$(curl -s https://api.github.com/repos/cli/cli/releases/latest |  grep "browser_download_url.*linux_amd64.tar.gz" | cut -d '"' -f 4)
VERSION=$(curl --silent "https://api.github.com/repos/cli/cli/releases/latest" | jq -r ".. .tag_name? // empty" | cut -c2- )
wget -q ${URL} -O ~/gh.tar.gz
tar --strip-components=2 -C ~/.local/bin/ -zxf ~/gh.tar.gz gh_${VERSION}_linux_amd64/bin/gh
rm ~/gh.tar.gz
hash -r
```

- [x] [GitHub cli (gh) login](https://cli.github.com/manual/gh_auth_login)

```bash
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
gh auth login
export GH_TOKEN=$(gh config get -h github.com oauth_token)
```
