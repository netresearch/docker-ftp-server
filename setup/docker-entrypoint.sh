#!/bin/bash
set -e

# Add Users and Home directories
arrUSERS=(${USERS//;/ })
for userAndPass in "${arrUSERS[@]}"
    do
        username=${userAndPass%%:*}
        # Check if user exists and create if not
        userInfo="$(id ${username} || echo 'no such user')"
        if [ "${userInfo}" == "no such user" ]; then
            adduser -h /home/./${username} -s /bin/false -D ${username}
            echo "Create user ${username}"
        fi
        echo "${userAndPass}" | /usr/sbin/chpasswd
        if [ -z ${GROUP} ]; then
            GROUP=${username}
        fi

        chown ${username}:${GROUP} /home/${username}/ -R
        chmod 2700 /home/${username}
        find /home/${username} -type d -exec chmod 2775 {} \;
        find /home/${username} -type f -exec chmod 0664 {} \;
done

# Fix vsftpd.conf permissions
chown root /etc/vsftpd/vsftpd.conf
chmod 664  /etc/vsftpd/vsftpd.conf

"$@"