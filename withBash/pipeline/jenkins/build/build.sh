#!/bin/bash

# Copia el jar

cp -f withBash/pipeline/java-app/target/*.jar withBash/pipeline/jenkins/build/  

echo "######################"
echo "*** Building image ***"
echo "######################"

cd withBash/pipeline/jenkins/build && docker-compose -f docker-compose-build.yml build --no-cache

