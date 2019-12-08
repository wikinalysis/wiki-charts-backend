#!/bin/bash

INSTANCE=$1
DATABASE=$2
PASSWORD=$3

if [[ -z $INSTANCE || -z $DATABASE || -z $PASSWORD ]];
then
    echo `date`" - Missing mandatory arguments: instance, database, and password. "
    echo `date`" - Usage: ./01_database.sh [instance] [database] [password]"
    exit 1
fi

## Setting up the database instance
gcloud sql instances create $INSTANCE --region=us-central1 --tier=db-f1-micro

gcloud sql users set-password root --host=% --instance=$INSTANCE --password=$PASSWORD

gcloud sql databases create $DATABASE --instance=$INSTANCE --charset=utf8mb4 --collation=utf8mb4_unicode_ci --async
