#!/bin/bash
set -e

addgroup -g $SITEGID -S sitecontent
adduser  -u $SITEUID -S sitecontent

case "$1" in
     build)
        mkdocs build
        ;;

     serve)
        mkdocs serve -a 0.0.0.0:8000
        ;;

       run)
        exec sh
        ;;

        *)
        echo "Acceptable commands: build, serve, run (drops into a shell)"
        ;;
esac

chown $SITEUID:$SITEGID -R /app/site

# vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent: