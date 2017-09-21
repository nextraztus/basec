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

# do the right thing if we have a TTY
if [ -t 1 ]
then
    TTYARGS="-ti"
else
    TTYARGS=""
fi

container_run() {
    docker build -t $COMPILEIMAGE -f Dockerfile . || exit 1
    docker run --rm=true                   \
               -v $(pwd):/app              \
               -p $SPORT:8000              \
               -e SITEUID=$(id -u)         \
               -e SITEGID=$(id -g)         \
               $TTYARGS                    \
               $COMPILEIMAGE $1
}

case "$1" in
        serve)
            container_run serve
            ;;

        run)
            container_run run
            ;;

        build)
            container_run build
            ;;

        *)
            echo "Usage: $0 {serve|run|build}"
            echo " serve -- servce the static site on port $PORT"
            echo "   run -- drop into a shell within the temporary container for debugging"
            echo " build -- compiles the site and dumps to /site"
            exit 1
esac

# vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent: