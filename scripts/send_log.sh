#!/bin/bash

# Get commandline arguments
while (( "$#" )); do
  case "$1" in
    --case)
      case="$2"
      shift
      ;;
    *)
      shift
      ;;
  esac
done

if [[ $case == "" ]]; then
  echo "Case number not given!"
  exit 1
fi

curl -X POST https://log-api.eu.newrelic.com/log/v1 \
  -H "Content-Type: application/json" \
  -H "Api-Key: ${NEWRELIC_LICENSE_KEY}" \
  -d '[{
    "logs": [{
        "message": "Understanding New Relic alerting - case'${case}'"
      }]
    }]'
