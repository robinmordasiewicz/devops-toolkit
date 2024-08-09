#!/bin/bash
#

USERNAME="nearbycatfish"
PASSWORD="GffJyzNI6xwpRwGT"

FQDN="${USERNAME}-management.canadacentral.cloudapp.azure.com:8443"
TOKEN=$(echo "{\"username\":\"${USERNAME}\",\"password\":\"${PASSWORD}\",\"vdom\":\"root\"}" | base64 | tr -d "\\n")

curl -v -k -H "Content-Type: multipart/form-data" -H "Authorization:${TOKEN}" -F 'openapifile=@../manifests/apps/ollama/openapi.yaml' --insecure "https://${FQDN}/api/v2.0/waf/openapi.openapischemafile"
