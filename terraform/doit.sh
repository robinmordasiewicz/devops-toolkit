#!/bin/bash
#

USERNAME=$(terraform output --json | jq -r '.admin_username.value')
PASSWORD=$(terraform output --json | jq -r '.admin_password.value')

FQDN="${USERNAME}-management.canadacentral.cloudapp.azure.com:8443"
TOKEN=$(echo "{\"username\":\"${USERNAME}\",\"password\":\"${PASSWORD}\",\"vdom\":\"root\"}" | base64 | tr -d "\\n")

# Create the swagger file
curl -k -H "Content-Type: multipart/form-data" -H "Authorization:${TOKEN}" -F 'openapifile=@../manifests/apps/ollama/openapi.yaml' --insecure "https://${FQDN}/api/v2.0/waf/openapi.openapischemafile" || true

# attach swagger file to new policy

curl "https://${FQDN}/api/v2.0/cmdb/waf/openapi-validation-policy" \
--insecure \
-X 'POST' \
-H "Authorization:${TOKEN}" \
-H 'Content-Type: application/json;charset=utf-8' \
-H 'Pragma: no-cache' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en-US,en;q=0.9' \
-H 'Cache-Control: no-cache' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Connection: keep-alive' \
--data-binary '{"data":{"q_type":1,"name":"ollama","action":"alert","action_val":"2","block-period":600,"severity":"Low","severity_val":"3","trigger":"","trigger_val":"0","sz_schema-file":-1}}'

curl "https://${FQDN}/api/v2.0/cmdb/waf/openapi-validation-policy/schema-file?mkey=ollama" \
  --insecure \
  -X 'POST' \
  -H 'Content-Type: application/json;charset=utf-8' \
  -H "Authorization:${TOKEN}" \
  -H 'Pragma: no-cache' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Connection: keep-alive' \
  --data-binary '{"data":{"openapi-file":"openapi.yaml"}}'

curl "https://${FQDN}/api/v2.0/cmdb/waf/openapi-validation-policy?mkey=ollama" \
  --insecure \
  -H "Authorization:${TOKEN}" \
-X 'PUT' \
-H 'Content-Type: application/json;charset=utf-8' \
-H 'Pragma: no-cache' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Cache-Control: no-cache' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Connection: keep-alive' \
--data-binary '{"data":{"can_view":0,"q_ref":0,"can_clone":1,"q_type":1,"name":"ollama","action":"alert","action_val":"2","block-period":600,"severity":"Low","severity_val":"3","trigger":"","trigger_val":"0","sz_schema-file":0}}'

# Create Custom Policy
curl "https://${FQDN}/api/v2.0/cmdb/waf/web-protection-profile.inline-protection" \
  --insecure \
  -H "Authorization:${TOKEN}" \
  -X 'POST' \
  -H 'Content-Type: application/json;charset=utf-8' \
  -H 'Pragma: no-cache' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Connection: keep-alive' \
  --data-binary '{"data":{"name":"ollama","client-management":"enable","amf3-protocol-detection":"disable","mobile-app-identification":"disable","token-header":"Jwt-Token","ip-intelligence":"disable","fortigate-quarantined-ips":"disable","quarantined-ip-action":"alert","quarantined-ip-severity":"High","rdt-reason":"disable","openapi-validation-policy":"ollama"}}'
