FROM jboss/base-jdk:8
MAINTAINER Andrew Bonham <>
EXPOSE 2181
ADD ./kafka_2.10-0.10.2.0.gz /opt/kafka_2.10-0.10.2.0.gz
RUN chmod -R 755 /opt/kafka_2.10-0.10.2.0.gz
CMD ["tar", "-xvf", "kafka_2.10-0.10.2.0.gz"]
ENTRYPOINT /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0/bin/zookeeper-server-start.sh /opt/kafka_2.10-0.10.2.0.gz/kafka_2.10-0.10.2.0//config/zookeeper.properties
