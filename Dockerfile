FROM alpine:3.7

RUN apk --update upgrade \
 && apk --no-cache add \
    bash \
    vsftpd

COPY /setup /

EXPOSE 20 21 10090-10100

ENTRYPOINT  ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]