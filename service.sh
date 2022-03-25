#!/bin/sh
mkdir -p ~borg/.ssh
echo "command=\"/usr/bin/borg serve --append-only --restrict-to-path /backup\" ssh-rsa $SSH_PUB_RSA" >> ~borg/.ssh/authorized_keys
chown borg:borg -R ~borg/.ssh
ssh-keygen -A
/usr/sbin/sshd -D -e
