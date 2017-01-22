FROM ubuntu:16.04

# Install system tools
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip nano wget && \
  rm -rf /var/lib/apt/lists/*


# Install Java
ARG JAVA_MAJOR_VERSION=8

RUN \
  echo oracle-java${JAVA_MAJOR_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd${JAVA_MAJOR_VERSION}team/java && \
  apt-get update && \
  apt-get install -y oracle-java${JAVA_MAJOR_VERSION}-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk${JAVA_MAJOR_VERSION}-installer

# Define JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_MAJOR_VERSION}-oracle


# Install Maven (Note: since the pre-build spark version is used here, the step of maven installation could be skipped)
RUN cd /home && \
    wget http://apache.volia.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
    tar xvf apache-maven-3.3.9-bin.tar.gz

# Add maven env. variables:
ENV M2_HOME /home/apache-maven-3.3.9
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH


# Install Spark
RUN cd /home && \
    wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz && \
    tar xvf spark-1.6.0-bin-hadoop2.6.tgz


CMD ["/bin/bash"]
