# base image
FROM alpine:latest

ENV USER=alpine

# Install packages
RUN apk add --update py3-pip mc ncdu wget aria2 htop fd nano busybox \
git lynx jq bc dos2unix gawk sed p7zip gzip markdown neofetch \
tmux curl cmatrix w3m bash figlet nmap sudo emacs gnupg

# upgrade pip
RUN pip3 install --upgrade pip

# install Python modules
COPY requirements.txt /usr/src/py3/
RUN pip3 install --no-cache-dir -r /usr/src/py3/requirements.txt

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/$USER" \
    --ingroup "users" \
    --shell "/bin/bash" \
    --uid "1001" \
    --system \
    "$USER"

RUN echo "$USER:$USER" | chpasswd && echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel && adduser $USER wheel

COPY .alias /home/$USER

USER $USER
WORKDIR /home/$USER

# run the application
CMD ["/bin/bash"]
