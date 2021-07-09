# base image
FROM alpine:latest

ENV USER=alpine

# Install packages
RUN apk add --update py3-pip mc ncdu aria2 htop fd nano busybox \
git lynx jq bc dos2unix gawk sed p7zip gzip markdown neofetch \
tmux curl cmatrix w3m bash figlet nmap sudo emacs gnupg \
mandoc man-pages less less-doc at newsboat

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

#COPY .alias .bashrc /home/$USER/
#COPY .newsboat/urls /home/$USER/.newsboat/

COPY homedir.tar.gz /home/$USER/
#RUN gunzip /home/$USER/homedir.tar.gz && tar -xvf /home/$USER/homedir.tar . && \
#rm /home/$USER/homedir.tar && \
#chown -R $USER:users /home/$USER/

USER $USER
WORKDIR /home/$USER

RUN gunzip homedir.tar.gz && tar -xvf homedir.tar . && \
rm homedir.tar && \
chown -R $USER:users .

# run the applicationn
CMD ["/bin/bash"]
