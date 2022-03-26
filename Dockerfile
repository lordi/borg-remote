FROM alpine:3
LABEL maintainer="lordi"

#Install Borg & SSH
RUN apk add --no-cache openssh=8.8_p1-r1 sshfs=3.7.2-r0 borgbackup=1.1.17-r2 supervisor=4.2.2-r2
RUN adduser -D -u 1000 borg && \
    passwd -u borg && \
    mkdir -m 0700 /backups && \
    chown borg.borg /backups && \
    sed -i \
        -e 's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' \
        -e 's/^#PubkeyAuthentication yes$/PubkeyAuthentication yes/g' \
        -e 's/^PermitRootLogin without-password$/PermitRootLogin no/g' \
        -e '$aPubkeyAcceptedAlgorithms=+ssh-rsa' \
        -e '$aPubkeyAcceptedKeyTypes=+ssh-rsa' \
        /etc/ssh/sshd_config

COPY service.sh /usr/local/bin/service.sh

EXPOSE 22
VOLUME /etc/ssh

CMD ["/usr/local/bin/service.sh"]
