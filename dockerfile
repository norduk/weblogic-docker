# Pull the minimal CentOS image
FROM centos:centos7.9.2009
ENV container docker
LABEL maintainer="Weblogic-docker"

# Configuration network
ENV NET_ADAPTER eth0
ENV HOST_ADDR localhost
ENV HOST_CONF_PORT 7001
EXPOSE 7001

# install java 
RUN yum -y install java-1.7.0-openjdk-devel

# Volume
VOLUME [ "/opt/hcfb/weblogic" ] 

# mkdir
RUN mkdir -p /opt/hcfb/weblogic

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