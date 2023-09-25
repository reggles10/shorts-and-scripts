#!/bin/bash

INSTANCES=`gcloud compute instances list | grep richard-eggleston | cut -d' ' -f1`
echo $INSTANCES

for instance in ${INSTANCES[@]}
do
gcloud compute instances stop $instance
done
