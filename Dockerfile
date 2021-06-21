FROM debian:stable-slim  AS builder
WORKDIR  /app
RUN  pwd && ls -l && echo "当前目录默认是  $(pwd)"\

RUN mkdir -p /app && pwd && ls -l && echo "当前目录是  $(pwd)"\

FROM scratch
COPY --from=builder .  .
