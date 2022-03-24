# base image
FROM alpine:latest

ENV USER=alpine

# Install packages
RUN apk add --update py3-pip mc ncdu aria2 htop fd nano busybox \
git git-lfs lynx jq bc dos2unix gawk sed p7zip gzip markdown neofetch \
tmux curl cmatrix w3m bash figlet nmap sudo emacs gnupg file exiftool \
mandoc man-pages less less-doc at newsboat libcaca-apps zsh tzdata \
colordiff docker tor torsocks age subversion sqlite mediainfo \
sysbench lshw && \
rm -rf /var/lib/apt/lists/* && \
rm /var/cache/apk/*

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
    --uid "1000" \
    --system \
    "$USER"

RUN echo "$USER:$USER" | chpasswd && echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel && adduser $USER wheel

COPY homedir.tar.gz /home/$USER/

# users
USER $USER
WORKDIR /home/$USER

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
cd .oh-my-zsh/custom/plugins && \
git clone https://github.com/zsh-users/zsh-autosuggestions

RUN gunzip homedir.tar.gz && tar -xvf homedir.tar . && \
rm homedir.tar && \
cat .zshrc2 >> .zshrc && \
rm .zshrc2 && \
./update_zshrc.sh && \
rm update_zshrc.sh && \
mkdir bin && \
curl -fsSL https://raw.githubusercontent.com/jarun/ddgr/main/ddgr > bin/ddgr && \
chmod u+x bin/* && \
chown -R $USER:users .

# run the applicationn
CMD ["/bin/zsh"]
