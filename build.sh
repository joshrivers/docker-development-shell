#!/bin/sh

MYDIR=$(cd $(dirname $0) && pwd)
DOCK_NAME='joshrivers/development-shell:local'
docker build -t $DOCK_NAME -f $MYDIR/Dockerfile .
echo "$DOCK_NAME"
