FROM alpine:latest
RUN apk add bind --no-cache
EXPOSE 53/udp

COPY ./internal/named.conf /etc/bind/named.conf
COPY ./internal/rpz.zone /var/named/rpz.zone
COPY ./blockdomains.conf /tmp/blockdomains.conf
RUN \
cat /tmp/blockdomains.conf | awk -F'[,]' '{printf "\n"}{for (i=1;i<=NF;i++) print $i"   0       IN  A   127.0.0.1" }' >> /var/named/rpz.zone &&\
named-checkzone rpz /var/named/rpz.zone &&\ 
named-checkconf /etc/bind/named.conf
CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf","-f"]
