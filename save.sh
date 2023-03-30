docker image save -o /tmp/docker-alpine-custom.tar ghcr.io/manegit/docker-alpine-custom:latest
gzip /tmp/docker-alpine-custom.tar
mv -f /tmp/docker-alpine-custom.tar.gz ~/

