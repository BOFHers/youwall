youwall
=======

You Wall Not Pass!! A script for ban IPS using hosts.deny and iptables


Usage
======

Usage:
```./youwall.sh <ip>```          Check if IP is on blacklist (DNSBL) and BAN!
```./youwall.sh -i```            Just read /etc/hosts.deny and BAN! with iptables every IP
```./youwall.sh -f <ip>```       Force add IP to hosts.deny and BAN! with iptables


You could add "youwall.sh -i" to your init scripts for re-ban after reboot
