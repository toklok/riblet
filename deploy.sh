#!/bin/bash

set -e

docker push jnerney/riblet
echo "$PEM" > riblet.pem
chmod 400 riblet.pem
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i "riblet.pem" $HOST 'bash redeploy.sh'