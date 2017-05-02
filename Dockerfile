FROM jboss/base-jdk:8

MAINTAINER Andy Bonham <>
 
USER root
 
RUN useradd -r -m -d /opt/jboss jboss
 
ENV HOME /opt/jboss
USER jboss
WORKDIR $HOME
 
ENV INSTALLERS_DIR /opt/jboss/installers
ENV SUPPORT_DIR /opt/jboss/support
ENV JBOSS_HOME /opt/jboss/bpms
ENV PATCH_DIR /opt/jboss/installers/patch
 
 
#Copy files
ADD installers/ $INSTALLERS_DIR
ADD support/ $SUPPORT_DIR
ADD patch/ $PATCH_DIR
USER root
RUN chown -R jboss:jboss $INSTALLERS_DIR $PATCH_DIR $SUPPORT_DIR
USER jboss
 
 
#Prepare install files with JBOSS_HOME
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$JBOSS_HOME</installpath>:" $SUPPORT_DIR/eap.xml \
&& sed -i "s:<installpath>.*</installpath>:<installpath>$JBOSS_HOME</installpath>:" $SUPPORT_DIR/bpms.xml
 
WORKDIR $HOME
 
RUN chmod 777 $INSTALLERS_DIR/jboss-eap-6.4.0-installer.jar
RUN java -jar $INSTALLERS_DIR/jboss-eap-6.4.0-installer.jar $SUPPORT_DIR/eap.xml -variablefile $SUPPORT_DIR/eap.xml.variables
RUN rm $INSTALLERS_DIR/jboss-eap-6.4.0-installer.jar
 
#Patch EAP
WORKDIR $JBOSS_HOME
RUN bin/standalone.sh --admin-only 2>&1 > /dev/null & sleep 4 && bin/jboss-cli.sh -c "patch apply $PATCH_DIR/jboss-eap-6.4.8-patch.zip,shutdown"
 
#Install BPMS
RUN chmod 777 $INSTALLERS_DIR/jboss-bpmsuite-6.3.0.GA-installer.jar
RUN java -jar $INSTALLERS_DIR/jboss-bpmsuite-6.3.0.GA-installer.jar $SUPPORT_DIR/bpms.xml -variablefile $SUPPORT_DIR/bpms.xml.variables
RUN rm $INSTALLERS_DIR/jboss-bpmsuite-6.3.0.GA-installer.jar
 
WORKDIR $HOME
 
#Add kieserver user
WORKDIR $JBOSS_HOME
RUN bin/add-user.sh -a -u kieserver -p kieserver1! --role rest-all,kie-server
 
USER root
RUN chown -R jboss:jboss $JBOSS_HOME
USER jboss
 
#Install custom profiles and modules
ONBUILD ADD configuration/ $JBOSS_HOME/standalone/configuration
ONBUILD ADD modules/ $JBOSS_HOME/modules
ONBUILD ADD maven/ /opt/jboss/.m2
 
ONBUILD USER root
ONBUILD RUN chown -R jboss:jboss $JBOSS_HOME
ONBUILD RUN chown -R jboss:jboss /opt/jboss/.m2
ONBUILD USER jboss
 
#Launch configuration
WORKDIR $JBOSS_HOME
ENV LAUNCH_JBOSS_IN_BACKGROUND true
ENTRYPOINT ["bin/standalone.sh", "-c"]
CMD ["standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

