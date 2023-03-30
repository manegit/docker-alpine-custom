docker run -it -v ~:/share -v /var/run/docker.sock:/var/run/docker.sock -e TZ=Europe/Berlin --name alpine-custom ghcr.io/manegit/docker-alpine-custom /bin/zsh
