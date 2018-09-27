#!/bin/bash
set -e

ECR_NAME=233739065563.dkr.ecr.eu-west-1.amazonaws.com/nix-builder-repository:latest
BUILD_NAME=nix-builder-repository

docker build -t $BUILD_NAME .
docker tag "${BUILD_NAME}:latest" $ECR_NAME
$(aws ecr get-login --no-include-email --region eu-west-1)
docker push $ECR_NAME
