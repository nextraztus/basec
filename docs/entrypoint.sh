#!/bin/bash
set -e

id -u builder 2>/dev/null || {
    BUILDUID=${BUILDUID:-0}
    BUILDGID=${BUILDGID:-0}

    if [ "$BUILDUID" -ne "0" ]
    then
        groupadd -g $BUILDGID builder
        useradd -ms /bin/bash -u $BUILDUID -g $BUILDGID builder
    fi
}

case "$1" in
     build)
        mkdocs build
        ;;

     serve)
        mkdocs serve -a 0.0.0.0:8000
        ;;

        *)
        echo "Acceptable commands: build, serve, run (drops into a shell)"
        ;;
esac

chown $SITEUID:$SITEGID -R /app/site

