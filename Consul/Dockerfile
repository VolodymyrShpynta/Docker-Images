FROM --platform=amd64 ubuntu:24.04

RUN apt update && apt install  openssh-server sudo -y

RUN userdel -r ubuntu

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test

RUN  echo 'test:test' | chpasswd

# ------ Install Consul: start (see https://developer.hashicorp.com/consul/tutorials/production-vms/deployment-guide) ------
#Install GnuPG:
RUN apt-get install curl gnupg lsb-release sudo -y

#Add the HashiCorp GPG key:
RUN curl --fail --silent --show-error --location https://apt.releases.hashicorp.com/gpg | \
      gpg --dearmor | \
      sudo dd of=/usr/share/keyrings/hashicorp-archive-keyring.gpg

#Add the official HashiCorp Linux repository:
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
 sudo tee -a /etc/apt/sources.list.d/hashicorp.list

#Update:
RUN sudo apt-get update

#Install the latest version of Consul:
RUN sudo apt-get install consul

#Prepare the security credentials:
#Generate the encryption key
RUN GOSSIP_SSH_KEY=$(consul keygen)

#Create the Certificate Authority:
RUN consul tls ca create

#Create the certificates:
RUN consul tls cert create -server -dc dc1 -domain consul

# ------ Install Consul: end --------

#Start ssh server:
RUN service ssh start

EXPOSE 22 8500

CMD ["/usr/sbin/sshd","-D"]
