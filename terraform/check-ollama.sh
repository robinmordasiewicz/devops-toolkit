#!/bin/bash
#

USERNAME=$(terraform output --json | jq -r '.admin_username.value')
FQDN="${USERNAME}.canadacentral.cloudapp.azure.com"

#curl "http://${FQDN}:80/v1/chat/completions" \


curl http://${FQDN}:80/api/generate -d '{
  "model": "codestral:latest",
  "prompt": "Why is the sky blue?",
  "stream": false,
  "options": {
    "temperature": 0
  },
}'

exit 0


curl "http://${FQDN}:80/v1/chat/comple" \
  -H "Content-Type: application/json" \
  -d '{
      "model": "codestral:latest",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content": "Hello!"
        }
       ]
     }'
