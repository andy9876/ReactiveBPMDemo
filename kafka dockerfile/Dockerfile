FROM jboss/base-jdk:8
MAINTAINER Andrew Bonham <>
EXPOSE 9092
ADD ./kafka_2.10-0.10.2.0.gz /opt/kafka_2.10-0.10.2.0.gz
RUN ls -ltr /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/bin
RUN chmod -R 755 /opt/kafka_2.10-0.10.2.0.gz
CMD ["tar", "-xvf", "kafka_2.10-0.10.2.0.gz"]
RUN chmod -R 755 /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0
RUN sed -i 's/localhost/$IP/g' /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/config/server.properties
ENTRYPOINT /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/bin/kafka-server-start.sh -d --name kafka kafka:latest /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/config/server.proper
ties --override zookeeper.connect=$IP:2181 --override advertised.listeners=PLAINTEXT://$IP:9092 --override advertised.host.name=$IP --override advertised.port=9092
