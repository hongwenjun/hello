FROM debian:stable-slim  AS builder
RUN  pwd && ls -l && echo "当前目录默认是  $(pwd)"\
WORKDIR  /app
RUN mkdir -p /app && pwd && ls -l && echo "当前目录是  $(pwd)"\

FROM scratch
COPY --from=builder .  .
