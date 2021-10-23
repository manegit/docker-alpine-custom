docker image save -o /tmp/docker-alpine-custom.tar mane1docker/alpine-custom:latest
gzip /tmp/docker-alpine-custom.tar
mv -f /tmp/docker-alpine-custom.tar.gz ~/

