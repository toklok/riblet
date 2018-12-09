#!/bin/bash

set -e

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -t jnerney/riblet:latest .

if [ "$TRAVIS_BRANCH" = develop ]; then
    docker push jnerney/riblet
    echo -e "$PEM" > riblet.pem
    chmod 400 riblet.pem
    ssh -o StrictHostKeyChecking=no -i "riblet.pem" -t ec2-user@$HOST 'bash -s' < ./redeploy.sh
fi