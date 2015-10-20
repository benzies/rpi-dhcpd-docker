FROM hypriot/rpi-alpine-scratch:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment variables.
ENV \
  TERM=xterm-color

# Install packages.
RUN apk update && \
    apk upgrade && \
    apk add bash dhcp nano wget && \
    rm -rf /var/cache/apk/*

# Add files to the container.
COPY entrypoint.sh /docker-entrypoint

# Define volumes.
VOLUME ["/etc/dhcp", "/var/lib/dhcp"]

# Expose ports.
EXPOSE 67/udp

# Define entrypoint.
ENTRYPOINT ["/docker-entrypoint"]

# Define command
CMD ["/usr/sbin/dhcpd", "-d", "-f", "-cf", "/etc/dhcp/dhcpd.conf", "-lf", "/var/lib/dhcp/dhcpd.leases", "--no-pid"]
