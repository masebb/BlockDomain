FROM alpine:latest
RUN apk add bind --no-cache
EXPOSE 53/udp

COPY ./internal/named.conf /etc/bind/named.conf
COPY ./internal/rpz.zone /var/named/rpz.zone
RUN \
named-checkconf /etc/bind/named.conf

CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf","-f"]
