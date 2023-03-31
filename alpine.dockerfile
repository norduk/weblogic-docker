FROM alpine:latest
# FROM openjdk:7-jdk-alpine
ENV container docker
LABEL maintainer="Weblogic-docker"

# Install PR
RUN apk add --no-cache openjdk7 

# mkdir
RUN mkdir -p /opt/hcfb/weblogic

# Volume
VOLUME [ "/opt/hcfb/weblogic" ] 

# CP
COPY wls1036_generic.jar /opt/hcfb/weblogic
COPY install.sh /opt/hcfb/weblogic
COPY test.py /opt/hcfb/weblogic

# install Weblogic
RUN chmod +x /opt/hcfb/weblogic/install.sh
RUN /opt/hcfb/weblogic/install.sh

# install Domain
RUN /opt/hcfb/weblogic/Oracle/Middleware/wlserver_10.3/common/bin/wlst.sh /opt/hcfb/weblogic/test.py


# Start weblogic
CMD /opt/hcfb/weblogic/domains/test/startWebLogic.sh