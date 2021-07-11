#!/bin/bash

unset CDPATH

# http://stackoverflow.com/a/246128/274549
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

SPORT=${PORT:-8000}
COMPILEIMAGE="baseccompiler:latest"

cd "$DIR"

# do the right thing if we have a TTY
if [ -t 1 ]
then
    TTYARGS="-ti"
else
    TTYARGS=""
fi

BUILDUID=$(id -u)
BUILDGID=$(id -g)

sudo docker build -t $COMPILEIMAGE -f Dockerfile . || exit 1
sudo docker run --rm=true \
            -v $(pwd):/compile \
            -e BUILDUID=$BUILDUID \
            -e BUILDGID=$BUILDGID \
            $TTYARGS \
            $COMPILEIMAGE $1
