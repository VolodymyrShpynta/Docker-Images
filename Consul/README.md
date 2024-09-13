# How to setup Consul within a Docker container

## Building the image
To build the image run `docker build -t IMAGE_NAME .` , once that's done you can run the image using
`docker run -it -p 22:22 IMAGE_NAME`. Finally, you can connect to the container using the user you created , in this case it will be test so
`ssh test@ip_address` enter your password in the prompt and your all setup.

> **_NOTE:_** in case when port 22 is not available on your machine, you can use another port.
For example, 222:
`docker run -it -p 222:22 IMAGE_NAME` and connect to the container using `ssh -p 222 test@ip_address`

# References: 
https://developer.hashicorp.com/consul/tutorials/production-vms/deployment-guide