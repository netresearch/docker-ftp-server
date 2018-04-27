#!/bin/bash
set -e

arrUSERS=(${USERS//;/ })
for userAndPass in "${arrUSERS[@]}"
    do
        username=${userAndPass%%:*}
        adduser -h /home/./${username} -s /bin/false -D ${username}
        echo "${userAndPass}" | /usr/sbin/chpasswd
        chown ${username}:${username} /home/${username}/ -R
        find /home/${username} -type d -exec chmod 2700 {} \;
        find /home/${username} -type f -exec chmod 0600 {} \;
done