FROM alpine

ARG GOVC_VERSION=0.22.1

RUN apk update
RUN apk add ca-certificates wget jq
RUN update-ca-certificates
RUN mkdir /out
RUN wget -nv https://github.com/vmware/govmomi/releases/download/v${GOVC_VERSION}/govc_linux_amd64.gz
RUN gunzip -d govc_linux_amd64.gz
RUN mv govc_linux_amd64 /out/govc
RUN chmod +x /out/*

FROM alpine
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /out/* /usr/local/bin/
CMD ["/bin/sh"]
