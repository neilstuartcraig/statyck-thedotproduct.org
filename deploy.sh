#!/bin/bash

set -e

FBASE_PROJECT="${1}"
OUTPUT_DIR="./output/latest"
DEPLOYMENT_FILES_DIR="./fbase_files"
CP_DEPLOY_FILES_CMD="cp -R ${DEPLOYMENT_FILES_DIR}/** ${OUTPUT_DIR}"
CD_DEPLOY_DIR_CMD="cd ${OUTPUT_DIR}"
FBASE_SETUP_CMD="firebase use $1"
FBASE_DEPLOY_CMD="firebase deploy"

if [ -z "${FBASE_PROJECT}" ]; then
    echo "Please specify the ID of the Firebase project you want to deploy to as the first argument. You can list Firebase projects via 'firebase list'"
fi

if [ -d $OUTPUT_DIR ]; then
    $CP_DEPLOY_FILES_CMD # Copy Firebase files to the deployment (files) dir
    $CD_DEPLOY_DIR_CMD # cd to the deployment (files) dir
    $FBASE_SETUP_CMD # Ensure we're using the correct Firebase project
    $FBASE_DEPLOY_CMD # Deploy to Firebase!
else
    echo "Couldn't find output directory ${OUTPUT_DIR}. Have you built the site?"
    exit 1
fi