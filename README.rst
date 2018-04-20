Netresearch docker image for to provide a ftp server
====================================================

This image provide a ftp server for one user which can be freely defined and is create on startup.

Usage
-----

docker::
  docker run --rm --name netresearch-ftp -d -e USER=foo -e PASSWORD=bar -v "$(pwd)/data:/home" -p "20:20" -p "21:21" -p "10090-10100:10090-10100" registry.netresearch.de/docker/ftp

docker-compose::
  ftp:
    image: registry.netresearch.de/docker/ftp
    environment:
      - USER=foo
      - PASSWORD=bar
    volumes:
      - "./data:/home"
    ports:
      - "20:20"
      - "21:21"
      - "10090-10100:10090-10100"
