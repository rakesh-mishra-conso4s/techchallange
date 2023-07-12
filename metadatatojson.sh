#!/bin/bash

metadata_url="http://169.254.169.254/metadata/instance?api-version=2021-02-01"

key_to_retrieve="compute"

metadata=$(curl -H "Metadata: true" "$metadata_url")
value=$(echo "$metadata" | jq -r ".$key_to_retrieve")

if [[ "$value" != "null" ]]; then
    echo "$value" | jq .
else
    echo "Key '$key_to_retrieve' not found in instance metadata."
fi