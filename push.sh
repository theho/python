#!/bin/sh
set -e

export PYTHON_IMAGE_TAG=3.14.0-$(date +%Y%m%d)

# Push the Docker image to the repository
docker push jimmyho/python:${PYTHON_IMAGE_TAG} --platform linux/amd64