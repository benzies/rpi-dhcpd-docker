FROM resin/rpi-raspbian:latest

MAINTAINER marc.lennox@gmail.com

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get -y upgrade
#RUN apt-get -y dist-upgrade
RUN apt-get install -y netmask isc-dhcp-server wget

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Move the existing configuration and data directories out of the way
RUN mv /etc/dhcp /etc/dhcp.orig
RUN mv /var/lib/dhcp /var/lib/dhcp.orig

# Define working directory.
WORKDIR /opt/dhcpd

# Add files to the container.
ADD . /opt/dhcpd
RUN wget --no-check-certificate https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework
RUN chmod +x pipework

# Define volumes.
VOLUME ["/etc/dhcp", "/var/lib/dhcp"]

# Expose ports.
EXPOSE 67/udp

# Define entrypoint.
ENTRYPOINT ["./entrypoint"]

# Define command
CMD ["-d", "-f", "-cf", "/etc/dhcp/dhcpd.conf", "-lf", "/var/lib/dhcp/dhcpd.leases", "--no-pid"]
