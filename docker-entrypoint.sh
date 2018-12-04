#! /bin/sh
set -u
[ -n "${DEBUG:-}" ] && set -x
RUNUSER_UID="${RUNUSER_UID:-1000}"
RUNUSER_GID="${RUNUSER_GID:-1000}"
# Refer to busybox 'adduser' manpage for details
addgroup -g ${RUNUSER_GID} runuser
adduser -s /bin/false -D -h /home/runuser -H -u ${RUNUSER_UID} -G runuser runuser
mkdir -p /home/runuser/.attic /home/runuser/.cache/attic
chown -R runuser:runuser /home/runuser/.attic /home/runuser/.cache/attic
exec su-exec runuser attic "$@"
