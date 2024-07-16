#!/bin/bash
#

cfos_license_input_file="CFOSVLTM24000026.lic"

if [ ! -f "$cfos_license_input_file" ]; then
    echo "${cfos_license_input_file} does not exist"
    exit 1
fi

file="manifests/base/store-firewall-license.yaml"
licensestring=$(sed '1d;$d' $cfos_license_input_file | tr -d '\n')
cat <<EOF >$file
---
apiVersion: v1
kind: ConfigMap
metadata:
    name: cfos-license
    labels:
        app: cfos
        category: license
data:
    license: |
        -----BEGIN CFOS LICENSE-----
        $licensestring
        -----END CMS-----
EOF
