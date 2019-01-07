#!/bin/bash

echo "########################"
echo "*** Preparing to push ***"
echo "########################"

IMAGE="app"

echo "*** Logging in ***"
docker login -u $PASS_USR -p $PASS_PSW docker.io
echo "*** Tagging image ***"
docker tag $IMAGE:$BUILD_TAG $PASS_USR/$IMAGE:$BUILD_TAG
echo "*** Pushing image ***"
docker push $PASS_USR/$IMAGE:$BUILD_TAG
