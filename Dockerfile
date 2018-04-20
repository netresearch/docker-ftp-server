FROM alpine:3.7

RUN apk --update --no-cache add vsftpd

COPY /setup /

EXPOSE 20 21 10090-10100

CMD /docker-entrypoint.sh