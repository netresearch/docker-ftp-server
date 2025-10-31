Netresearch Docker image to provide a FTP server
================================================

This image provides a FTP server for multiple users which can be freely defined
and are created on startup and have the purpose to provide a central ftp service for other docker containers.


To share the data managed by the sftp container mount the ``/home`` directory to a named volume or to a path on your host.

You can also adjust the vsftpd configuration by mounting your own configuration to ``/etc/vsftpd/vsftpd.conf`` inside the container.
Please note that the entrypoint will adjust the ownership and permissions on your mounted file to get the service up and running.

Build
-----

To build the image use the provided docker-compose.yml::

  docker-compose build
  docker-compose push


Usage
-----

Run directly with Docker CLI:

.. code-block:: shell

  docker run --rm -d \
    --name netresearch-ftp \
    -e USERS=user1:pass1;user2:pass2 \
    -v "$(pwd)/data:/home" \
    -p "20:20" -p "21:21" -p "10090-10100:10090-10100" \
    registry.netresearch.de/docker/ftp


To run with docker-compose, you need to create your own docker-compose.yml:

.. code-block:: yaml

  ftp:
    image: registry.netresearch.de/docker/ftp
    environment:
      - USERS=user1:pass1;user2:pass2
    volumes:
      - "./data:/home"
    ports:
      - "20:20"
      - "21:21"
      - "10090-10100:10090-10100"


Configuration
-------------

Some common configuration could be done via environment variables. ::

    environment:
      ## User which should be created on the server an have thier own directory
      - USERS=foo:tGpvcxMKCEcEP8d9lMfnQ3bQcdLj6tFl;bar:ji7U9U6Wh6TA3ymuL6IJjeqxM8Qkcs46
      ## Enables the transfer log
      - ENABLE_LOGGING=yes
      ## Enable the passive mode. If this option is enabled please check the following option.
      - ENABLE_PASSIVE_MODE=yes
      ## Startport for passive mode port range. Required if passive mode is enabled.
      - PASSIVE_MODE_MIN_PORT=10090
      ## Endport for passive mode port range. Required if passive mode is enabled.
      - PASSIVE_MODE_MAX_PORT=10100
      ## Address for passive mode, eg server public ip or server address. Required if passive mode is enabled.
      - PASSIVE_MODE_ADDRESS=sobol.nr
      ## Resolve the passive mode address. Required if the PASSIVE_MODE_ADDRESS is a name.
      - PASSIVE_MODE_RESOLVE=yes


Logging
-------

If the transfer log is enabled it will be stored in /var/log/vsftp.log within the container.


Security Considerations
-----------------------

This image is configured with ``allow_writeable_chroot=YES`` to enable compatibility with Docker 20.10.14 and newer versions. This setting allows FTP users to have write access to their chroot root directory, which is necessary for the container to function properly since user home directories are created with write permissions.

**Security Trade-off**: Allowing writable chroot directories disables vsftpd's security check that prevents potential chroot escape attacks. This is acceptable for:

* Internal/development environments
* Trusted users only
* Containerized environments with proper network isolation

**Recommendations for production use**:

* Use network isolation and firewall rules to restrict FTP access
* Only create accounts for trusted users
* Consider using SFTP instead of FTP for better security
* Keep the container and host system updated with security patches




