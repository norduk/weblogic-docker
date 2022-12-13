# Pull the minimal CentOS image
FROM scratch
ADD centos-7-x86_64-docker.tar.xz /
ENV container docker
LABEL \
    org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20201113" \
    org.opencontainers.image.title="CentOS Base Image" \
    org.opencontainers.image.vendor="CentOS" \
    org.opencontainers.image.licenses="GPL-2.0-only" \
    org.opencontainers.image.created="2020-11-13 00:00:00+00:00" \
    maintainer="Weblogic-docker"

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

# install Weblogic
RUN chmod +x /opt/hcfb/weblogic/install.sh
RUN /opt/hcfb/weblogic/install.sh

CMD ["/usr/sbin/init"]