#!/bin/bash

echo "****************"
echo "* Building jar!*"
echo "****************"

PROJ=/home/chris/Development/Jenkins/jenkins-pipeline/withBash/pipeline
docker run --rm -v /root/.m2:/root/.m2 -v $PROJ/java-app:/app -w /app maven:3-alpine "$@"
