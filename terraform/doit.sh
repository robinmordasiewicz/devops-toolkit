#!/bin/bash
#

FQDN="enhancedtick-management.canadacentral.cloudapp.azure.com:8443"
USERNAME="enhancedtick"
PASSWORD="k4bmR6S0bDMXrMtn"
TOKEN=$(echo "{'username':"${USERNAME}",'password':"${PASSWORD}",'vdom':'root'}" | base64 | tr -d '\n')

#curl -v -k -X POST -H "Content-Type: multipart/form-data" -H "Authorization:${TOKEN}" -F 'openapifile=@../manifests/apps/ollama/openapi.yaml' --insecure "https://${FQDN}/api/v2.0/waf/openapi.openapischemafile"

curl -v -k -X POST -H "Content-Type: multipart/form-data" -H "Authorization:${TOKEN}" -F 'openapifile=@petstore.yaml' --insecure "https://${FQDN}/api/v2.0/waf/openapi.openapischemafile"

#curl -v -k -X POST -H "Content-Type: multipart/form-data" -H "Authorization:${TOKEN}" -F 'openapifile=@../manifests/apps/ollama/openapi.yaml' --insecure "https://${FQDN}/api/v2.0/waf/openapi.openapischemafile"
