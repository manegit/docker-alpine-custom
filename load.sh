gunzip -k ../docker-alpine-custom.tar.gz
docker image load -i ../docker-alpine-custom.tar
rm ../docker-alpine-custom.tar
