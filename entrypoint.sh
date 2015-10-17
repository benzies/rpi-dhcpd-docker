#!/bin/sh
set -e

# Copy a default configuration into place if one not there
if ! [ -f /etc/dhcp/dhcpd.conf ]; then
  cp /etc/dhcp/dhcpd.conf.example /etc/dhcp/dhcpd.conf
fi

# Create an empty leases file in place if one is not there
if [ ! -f /var/lib/dhcp/dhcpd.leases ]; then
  touch /var/lib/dhcp/dhcpd.leases
fi

exec "$@"
