#!/bin/bash

echo "########################"
echo "*** Preparing to push ***"
echo "########################"

IMAGE="app"

echo "*** Logging in ***"
docker login -u chrismarm -p development85 docker.io
echo "*** Tagging image ***"
docker tag $IMAGE:$BUILD_TAG chrismarm/$IMAGE:$BUILD_TAG
echo "*** Pushing image ***"
docker push chrismarm/$IMAGE:$BUILD_TAG
