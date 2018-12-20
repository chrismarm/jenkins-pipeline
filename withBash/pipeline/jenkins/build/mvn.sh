#!/bin/bash

echo "****************"
echo "* Building jar!*"
echo "****************"

PROJ=/var/jenkins_home/workspace/pipeline-maven/withBash/pipeline
docker run --rm -v /root/.m2:/root/.m2 -v $PROJ/java-app:/app -w /app maven:3-alpine "$@"
