#!/bin/bash

set -e

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -t jnerney/riblet:latest .

if [ "$TRAVIS_BRANCH" = develop ]; then
    docker push jnerney/riblet
    echo "$PEM" > riblet.pem
    chmod 400 riblet.pem
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i "riblet.pem" ec2-user@$HOST 'bash redeploy.sh'
fi