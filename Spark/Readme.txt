#Building the image:
sudo docker build -t my-spark-1.6.0 .

#Running the image:
sudo docker run -it -p 8080:8080 my-spark-1.6.0 /bin/bash
or
sudo docker run -it my-spark-1.6.0 /bin/bash