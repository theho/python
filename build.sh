#!/bin/sh
set -e

export PYTHON_IMAGE_TAG=3.14.0-$(date +%Y%m%d)

# Build the Docker image
docker build --platform linux/amd64 -t jimmyho/python:${PYTHON_IMAGE_TAG} .
