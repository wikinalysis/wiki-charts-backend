#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)
BUCKET_NAME="${PROJECT_ID}-releases"

TEMPLATE=$1
GROUP=$2

if [[ -z $TEMPLATE || -z $GROUP ]];
then
    echo `date`" - Missing mandatory arguments: instance and database. "
    echo `date`" - Usage: ./05_instance_group.sh [template] [group]"
    exit 1
fi

gcloud compute instance-templates create $TEMPLATE \
--image-family debian-9 \
--image-project debian-cloud \
--machine-type f1-micro \
--scopes "userinfo-email,cloud-platform" \
--metadata-from-file startup-script=instance-startup.sh \
--metadata release-url=gs://${BUCKET_NAME}/release \
--tags http-server

gcloud compute instance-groups managed create $GROUP \
--base-instance-name $GROUP \
--size 1 \
--template $TEMPLATE \
--zone us-central1-f

echo `date`" - Managed Instance Group created with name ${GROUP}"