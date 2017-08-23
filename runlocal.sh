#!/bin/sh

MYDIR=$(cd $(dirname $0) && pwd)
DOCK_NAME='joshrivers/development-shell:local'
docker run --rm -ti --volume /var/run/docker.sock:/var/run/docker.sock --volume $(cd ~/.aws && pwd):/root/.aws $DOCK_NAME
