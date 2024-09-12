# How to setup an ssh server within a docker container

## Why run an ssh server within a container in the first place?

The major reason why you might want to do this is for testing purposes, perhaps you are testing infrastructure automation or provisioning with something like ansible which requires ssh access to the target machine, you'd want to test this in a safe environment before going live.

This article assumes you have docker installed on your machine if not you can refer to this page to get it installed 
[here](https://docs.docker.com/get-started/get-docker/).

## The Dockerfile!
```dockerfile
FROM ubuntu:24.04

RUN apt update && apt install  openssh-server sudo -y

RUN userdel -r ubuntu

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 

RUN  echo 'test:test' | chpasswd

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
```
Here I am using ubuntu as the base image for the container, then on line 2 i install open-ssh server and sudo.
### Sudo?
By default, docker does not have sudo installed , hence the need to install it along with the open ssh server

On line 3 I delete "ubuntu" user (and /home/ubuntu directory) and now uid 1000 is free for use by another user.

On line 4 I create a user called test and add it to the sudo group `echo 'test:test' | chpasswd` sets the password for the user test to test

Line 5 starts the ssh service and line 6 tells docker the container listens on port 22 ( which is the default for ssh) and finally i start the ssh daemon.

## Building the image
To build the image run `docker build -t IMAGE_NAME .` , once that's done you can run the image using 
`docker run -it -p 22:22 IMAGE_NAME`. Finally, you can connect to the container using the user you created , in this case it will be test so 
`ssh test@ip_address` enter your password in the prompt and your all setup.

> **_NOTE:_** in case when port 22 is not available on your machine, you can use another port.
For example, 222:
`docker run -it -p 222:22 IMAGE_NAME` and connect to the container using `ssh -p 222 test@ip_address` 

# References: 
https://dev.to/s1ntaxe770r/how-to-setup-ssh-within-a-docker-container-i5i