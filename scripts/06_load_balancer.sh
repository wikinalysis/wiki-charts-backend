#!/bin/bash

PREFIX=$1
GROUP=$2

if [[ -z $PREFIX || -z $GROUP ]];
then
    echo `date`" - Missing mandatory arguments: prefix and group. "
    echo `date`" - Usage: ./06_load_balancer.sh [prefix] [group]"
    exit 1
fi

gcloud compute http-health-checks create ${PREFIX}-health-check \
--request-path / \
--port 8080

gcloud compute instance-groups managed set-named-ports $GROUP \
--named-ports http:8080 \
--zone us-central1-f

gcloud compute backend-services create ${PREFIX}-service \
--http-health-checks ${PREFIX}-health-check \
--global

gcloud compute backend-services add-backend ${PREFIX}-service \
--instance-group $GROUP \
--global \
--instance-group-zone us-central1-f

gcloud compute url-maps create ${PREFIX}-service-map \
--default-service ${PREFIX}-service

gcloud compute target-http-proxies create ${PREFIX}-service-proxy \
--url-map ${PREFIX}-service-map

gcloud compute forwarding-rules create ${PREFIX}-http-rule \
--target-http-proxy ${PREFIX}-service-proxy \
--ports 80 \
--global

echo `date`" - Load Balancer created for ${GROUP}, identified by the ${PREFIX} prefix"