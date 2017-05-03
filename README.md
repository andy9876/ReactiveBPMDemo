# ReactiveBPMDemo

This repo contains the code for the POC that is part of RedHat Session S103127:  Using BPM Suite in a reactive architecture with microservices deployed in Docker containers and managed in Amazon ECS (EC2 Container Service)


# BPM Suite Dockerfile and setup files
Dockerfile - This file can be used to build a docker imaging of BPM Suite.
For it to work, you need to create 3 directories:  patch, installers, and support.
It currently installs BPM Suite 6.3 and EAP 6.4.8.
You will need to download the binaries from the RedHat site and put them into the appropriate folders.

* Download the BPM Suite and EAP installers and upload them to the installers directory.
   * jboss-bpmsuite-6.3.0.GA-installer.jar
   * jboss-eap-6.4.0-installer.jar
* Download the patch for EAP 6.4.8 and upload this to the patch directory.
   * jboss-eap-6.4.8-patch.zip
* Download these files in the support folder:
    * eap.xml
    * eap.xml.variables
    * bpms.xml
    * bpms.xml.variables

After building the image, use the below command to run the docker container
```docker run -p 8080:8080 -p 8001:8001 -d bpmsuite```

# Kie Server Kafka Extension
You can find David Murphy's kie server kafka extension at the below repo
https://gitlab.com/murph83/kie-server-kafka.git

# BPM Suite project
This contains the source code for the bpm suite fraud example 

# RunModelMS
This is a java based microservice that generates a random value in the action attribute of either "Tranaction OK" or "Fraudulent Transaction", for example:

  ```{"id": "33bb75db-6e13-48ee-8a54-b3976d3d065b","action": "Run Fraud Model"}```

Leverage the Dockerfile to build the container.
To run the docker container:

  ```docker run -d runmodelms:latest```

# Kafka and Zookeeper Dockerfiles
The included Dockerfiles require kafka_2.10-0.10.2.0.gz, you can download this off of https://kafka.apache.org/downloads

To run these containers:

  ```docker run -p 9092:9092 --entrypoint /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/bin/kafka-server-start.sh -d --name kafka kafka:latest /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/config/server.properties --override zookeeper.connect=<zookeeperIP>:2181 --override advertised.listeners=PLAINTEXT://<kafkaIP>:9092 --override advertised.host.name=<kafkaIP> --override advertised.port=9092```
  
  ```docker run -p 2181:2181 --name zookeeper -d zookeeper:latest```




