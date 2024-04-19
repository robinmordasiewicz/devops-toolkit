#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Default values for arguments
publisher="fortinet"
location="canadacentral"
offer="fortigate"
sku="payg"
plan="$sku"
version="latest"

# Loop through arguments and process them based on switch
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -p|--publisher) # Handle the publisher switch
            publisher="$2"
            shift 2
            ;;
        -l|--location) # Handle the location switch
            location="$2"
            shift 2
            ;;
        -f|--offer) # Handle the offer switch
            offer="$2"
            shift 2
            ;;
        --sku) # Handle the SKU switch
            sku="$2"
            plan="$2"  # Sets plan to the same value as sku unless explicitly set later
            shift 2
            ;;
        --plan) # Handle the plan switch, independent of SKU if needed
            plan="$2"
            shift 2
            ;;
        --version) # Handle the version switch
            version="$2"
            shift 2
            ;;
        -h|--help) # Handle help switch
            echo "Usage: $0 [--publisher ${publisher}] [--location ${location}] [--offer (fortigate|fortiweb)] [--plan or --sku (payg|byol|fortiflex)] [--version ${version}]"
            exit 0
            ;;
        *) # Handle unknown option
            echo "Unknown option: $1"
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
    esac
done

if [[ "${publisher}" == "fortinet" && "${sku}" != *"pay"* ]]; then
  az vm image list --publisher "${publisher}" --location "${location}" --all -o json --query "sort_by([?contains(offer, '${offer}') && !contains(sku, '${sku}')], &version)[-1]"
else
  az vm image list --publisher "${publisher}" --location "${location}" --all -o json --query "sort_by([?contains(offer, '${offer}') && contains(sku, '${sku}')], &version)[-1]"
fi
