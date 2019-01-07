#!/bin/bash

echo "################"
echo "*** Testing  ***"
echo "################"

PROJ=/home/chris/Development/Jenkins/jenkins-pipeline/withBash/jenkins_home/workspace/pipeline-docker/withBash/pipeline
docker run --rm -v /root/.m2:/root/.m2 -v $PROJ/java-app:/app -w /app maven:3-alpine "$@"

