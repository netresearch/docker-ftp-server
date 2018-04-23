#!/bin/bash
set -e

arrUSERS=(${USERS//;/ })
for userAndPass in "${arrUSERS[@]}"
    do
        username=${userAndPass%%:*}
        adduser -h /home/./${username} -s /bin/false -D ${username}
        echo "${userAndPass}" | /usr/sbin/chpasswd
        chown ${username}:${username} /home/${username}/ -R
done

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf