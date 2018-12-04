#! /bin/sh
set -u
[ -n "${DEBUG:-}" ] && set -x

RUNUSER="${RUNUSER:-root}"
RUNUSER_SHELL="${RUNUSER_SHELL:-/bin/sh}"

if [ "$RUNUSER" = "root" ] ; then
    RUNUSER_HOME=/root
    RUNUSER_UID=0
    RUNUSER_GID=0
else
    RUNUSER_HOME="/home/$RUNUSER"
    RUNUSER_UID="${RUNUSER_UID:-1000}"
    RUNUSER_GID="${RUNUSER_GID:-1000}"
fi

# Refer to busybox 'adduser' manpage for details
[ $RUNUSER_UID -ne 0 ] && addgroup -g ${RUNUSER_GID} $RUNUSER
[ $RUNUSER_UID -ne 0 ] && adduser -s $RUNUSER_SHELL -D -h $RUNUSER_HOME -H -u ${RUNUSER_UID} -G $RUNUSER $RUNUSER
mkdir -p $RUNUSER_HOME/.attic $RUNUSER_HOME/.cache/attic
chown -R $RUNUSER:$RUNUSER $RUNUSER_HOME/.attic $RUNUSER_HOME/.cache/attic
exec su-exec $RUNUSER attic "$@"
