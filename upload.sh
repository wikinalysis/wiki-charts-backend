#!/bin/bash

IMAGE_TAG=wiki-backend

docker build -t $IMAGE_TAG .
container_id=$(docker create $IMAGE_TAG)
docker cp ${container_id}:/app/start_release /tmp/start_release
docker rm ${container_id}
gsutil cp start_release gs://wikinalysis-production-releases/release
rm start_release