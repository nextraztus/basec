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
COMPILEIMAGE="mkdocsrenderer:latest"

cd "$DIR"

# do the right thing if we have a TTY
if [ -t 1 ]
then
    TTYARGS="-ti"
else
    TTYARGS=""
fi

SITEUID=$(id -u)
SITEGID=$(id -g)

container_run() {
    sudo docker build -t $COMPILEIMAGE -f Dockerfile . || exit 1
    sudo docker run --rm=true \
               -v $(pwd):/app \
               -p 127.0.0.1:$SPORT:8000 \
               -e SITEUID \
               -e SITEGID \
               $TTYARGS \
               $COMPILEIMAGE $1
}

case "$1" in
        serve)
            container_run serve
            ;;

        build)
            container_run build
            ;;

        *)
            echo "Usage: $0 {serve|run|build}"
            echo " serve -- servce the static site on port $PORT"
            echo " build -- compiles the site and dumps to /site"
            exit 1
esac
