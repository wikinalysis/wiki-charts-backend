#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)
BUCKET_NAME="${PROJECT_ID}-releases"

IMAGE_TAG=$1

if [[ -z $IMAGE_TAG ]];
then
    echo `date`" - Missing mandatory arguments: image tag. "
    echo `date`" - Usage: ./02_artifacts.sh [image tage]"
    exit 1
fi

gsutil mb gs://${BUCKET_NAME}

## Building and deploying the image
docker build -t $IMAGE_TAG .
container_id=$(docker create $IMAGE_TAG)
docker cp ${container_id}:/app/start_release start_release
docker rm ${container_id}
gsutil cp start_release gs://${BUCKET_NAME}/release
rm start_release

echo `date`" - Bucket Created, OTP Release Uploaded"