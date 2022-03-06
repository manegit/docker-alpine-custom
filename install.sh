docker run -it -v ~:/share -v /var/run/docker.sock:/var/run/docker.sock -e TZ=Europe/Berlin --name alpine-custom mane1docker/alpine-custom:latest /bin/zsh
