#!/bin/bash

echo "########################"
echo "*** Preparing to push ***"
echo "########################"

IMAGE="app"

echo "*** Logging in ***"
docker login -u chrismarm -p $PASS
echo "*** Tagging image ***"
docker tag $IMAGE:$BUILD_TAG $IMAGE:$BUILD_TAG
echo "*** Pushing image ***"
docker push $IMAGE:$BUILD_TAG
