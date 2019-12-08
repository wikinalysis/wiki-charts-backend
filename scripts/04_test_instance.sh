#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)
BUCKET_NAME="${PROJECT_ID}-releases"

INSTANCE=$1

if [[ -z $INSTANCE ]];
then
    echo `date`" - Missing mandatory arguments: instance. "
    echo `date`" - Usage: ./04_test_instance.sh [instance]"
    exit 1
fi

gcloud compute instances create $INSTANCE \
--image-family debian-9 \
--image-project debian-cloud \
--machine-type f1-micro \
--scopes "userinfo-email,cloud-platform" \
--metadata-from-file startup-script=instance-startup.sh \
--metadata release-url=gs://${BUCKET_NAME}/release \
--zone us-central1-f \
--tags http-server

echo `date`" - Compute Engine Instance created with name ${INSTANCE}"