FROM ubuntu:24.04

RUN apt update && apt install  openssh-server sudo -y

RUN userdel -r ubuntu

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test

RUN  echo 'test:test' | chpasswd

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
