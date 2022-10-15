FROM alpine AS builder
RUN apk add -U --no-cache \
      binutils \
      gzip  && \
    wget -O /tmp/yq \
      https://github.com/mikefarah/yq/releases/download/v4.28.1/yq_linux_amd64  && \
    chmod a+x /tmp/yq  && \
    strip /tmp/yq && \
    gzexe /tmp/yq

FROM busybox
COPY --from=builder /tmp/yq /bin/yq
ENTRYPOINT ["/bin/yq"]
