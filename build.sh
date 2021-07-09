cd usrhomedir
tar -zcvf ../homedir.tar .
cd ..
gzip homedir.tar
docker build -t mane1docker/alpine-custom .
