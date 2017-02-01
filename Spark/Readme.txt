#Building the image:
docker build -t my-spark-1.6.0 .

#Running the image:
docker run -it -p 8080:8080 my-spark-1.6.0 /bin/bash
or
docker run -d -it -p 22 -p 80 --name worker-1 my-spark-1.6.0
or
docker run -it my-spark-1.6.0 /bin/bash

#Get IP address:
docker inspect worker-1 | grep -i ipaddr