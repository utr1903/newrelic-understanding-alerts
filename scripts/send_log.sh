#!/bin/bash

curl -X POST https://log-api.eu.newrelic.com/log/v1 \
  -H "Content-Type: application/json" \
  -H "Api-Key: ${NEWRELIC_LICENSE_KEY}" \
  -d '[{
    "logs": [{
        "message": "Understanding New Relic alerting - case01"
      }]
    }]'
