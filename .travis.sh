#!/bin/bash

set -e

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -t $DOCKER_USERNAME/riblet:latest .

if [ "$TRAVIS_BRANCH" = develop ]; then
    docker push $DOCKER_USERNAME/riblet
    echo -e "$PEM" > riblet.pem
    chmod 400 riblet.pem
    ssh -o StrictHostKeyChecking=no -i "riblet.pem" -t ec2-user@$HOST  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD && docker pull $DOCKER_USERNAME/riblet && docker run $DOCKER_USERNAME/riblet
fi