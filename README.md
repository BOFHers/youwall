youwall
=======

You Wall Not Pass!! A script for ban IPS using hosts.deny and iptables. This script has the ability to check if ip is on DNSBL.


Usage
======

Usage:
* ```./youwall.sh <ip>```          Check if IP is on blacklist (DNSBL) and BAN!
* ```./youwall.sh -i```            Just read /etc/hosts.deny and BAN! with iptables every IP
* ```./youwall.sh -f <ip>```       Force add IP to hosts.deny and BAN! with iptables (and without DNSBL check)


You could add ```youwall.sh -i``` to your init scripts for re-ban after reboot
