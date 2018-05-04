Netresearch Docker image to provide a FTP server
================================================

This image provides a FTP server for multiple users which can be freely defined 
and are created on startup.


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


Build
-----

To build the image use the provided docker-compose.yml::

  docker-compose build
  docker-compose push
