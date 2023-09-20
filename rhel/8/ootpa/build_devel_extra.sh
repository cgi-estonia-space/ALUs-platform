#!/bin/bash

set -ex

image_name="cgialus/alus-ootpa-devel-extra:latest"
docker_file="devel-extra.Dockerfile"

docker login
docker build "$@" -t $image_name -f $docker_file .
docker tag $image_name $image_name 
docker push $image_name

