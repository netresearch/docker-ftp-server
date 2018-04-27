Netresearch Docker image for to provide a FTP server
====================================================

This image provides a ftp server for multiple users which can be freely defined and are created on startup.

Usage
-----

docker::

  docker run --rm --name netresearch-ftp -d -e USERS=user1:pass1;user2:pass2 -v "$(pwd)/data:/home" -p "20:20" -p "21:21" -p "10090-10100:10090-10100" registry.netresearch.de/docker/ftp

docker-compose::

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

Build
-----

To build the image use docker-compose::

  docker-compose build
  docker-compose push
