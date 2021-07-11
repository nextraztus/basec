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

cd /compile

if [ "$BUILDUID" -ne "0" ]
then
    sudo -H -u builder make $@
    chown $BUILDUID:$BUILDGID -R /compile/build
else
    echo "Building as root."
    make $@
fi
