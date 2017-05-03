FROM jboss/base-jdk:8
MAINTAINER Andrew Bonham <>
ADD ConsumerGroupRunModelMS.jar /home/ConsumerGroupRunModelMS.jar
RUN chmod 755 /home/ConsumerGroupRunModelMS.jar
RUN mkdir /home/conf
RUN chmod 777 /home/conf
ADD Decision.yaml /home/conf
RUN chmod 755 /home/conf/Decision.yaml
ENTRYPOINT java -jar /home/ConsumerGroupRunModelMS.jar 172.31.14.202:2181 decisioning card.transaction 1
