#!/bin/bash

BUCKET_NAME="tdp-statyck-web"

# Create bucket if !exists
gsutil mb gs://$BUCKET_NAME

# Sync, not copy (we want to remove items from the dest which are not in src)
gsutil -m rsync -d -r ./output/latest/ gs://$BUCKET_NAME


# it'd be good to (at some point) generate a caddy file from the assets
# need to minify content
