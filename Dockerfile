FROM alpine AS builder
RUN apk add -U --no-cache \
      binutils \
      upx  && \
    wget -O /tmp/yq \
      https://github.com/mikefarah/yq/releases/download/v4.35.1/yq_linux_amd64  && \
    chmod a+x /tmp/yq  && \
    strip /tmp/yq && \
    upx /tmp/yq

FROM busybox
COPY --from=builder /tmp/yq /bin/yq
ENTRYPOINT ["/bin/yq"]
