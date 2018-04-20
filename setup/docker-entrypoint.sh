#!/bin/sh

adduser -h /home/./${USER} -s /bin/false -D ${USER}
echo "${USER}:${PASSWORD}" | /usr/sbin/chpasswd
chown ${USER}:${USER} /home/${USER}/ -R

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf