#!/bin/bash

set -ex

docker login
docker build "$@" -t cgialus/alus-ootpa-devel:latest -f devel.Dockerfile .
docker tag cgialus/alus-ootpa-devel:latest cgialus/alus-ootpa-devel:latest
docker push cgialus/alus-ootpa-devel:latest

