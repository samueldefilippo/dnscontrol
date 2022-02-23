FROM golang:rc-alpine3.14 as base
RUN apk add git
WORKDIR /data
RUN git clone https://github.com/StackExchange/dnscontrol 
COPY ovhProvider.go /data/dnscontrol/providers/ovh/ovhProvider.go
COPY protocol.go /data/dnscontrol/providers/ovh/protocol.go
RUN cd dnscontrol && go build
RUN chmod 755 dnscontrol
#RUN ls -lha --color /data/dnscontrol/

FROM alpine:3.14
COPY --from=base /data/dnscontrol/dnscontrol /dnscontrol
# RUN ls -lha --color /
ENTRYPOINT ["/dnscontrol"]
