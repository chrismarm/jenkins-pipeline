#!/bin/bash

# Store in a file all the needed data to be used in the production server to pull the image and run the container with the app
echo app > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS_USR >> /tmp/.auth
echo $PASS_PWD >> /tmp/.auth


# We transfer the file with the info, the script to login and run the docker-compose and the docker-compose itself
scp -i withBash/production-server/jenkins-access /tmp/.auth  production@production-server:/tmp/.auth
scp -i withBash/production-server/jenkins-access withBash/pipeline/jenkins/deploy/publish production@production-server:/tmp/publish
scp -i withBash/production-server/jenkins-access withBash/pipeline/jenkins/deploy/docker-compose.yml production@production-server:/home/production/docker-compose-yml
ssh -i withBash/production-server/jenkins-access production@production-server /tmp/publish
