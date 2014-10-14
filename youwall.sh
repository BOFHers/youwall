#!/bin/bash
# Writed by JA Nache <nache.nache@gmail.com>
# Description: Ban a IP using hosts.deny and iptables. This script uses a list from DNSBL
# Dependences: rblcheck
# License: Public Domain

function banip {
	iptables -L ocasofirewall -v -n | grep DROP | grep $1
	if [ $? -eq 1 ]
	then
		iptables -A ocasofirewall -s $1 -j DROP
		echo "$1 BAN! (iptables)"
	else
		echo "$1 is already banned in iptables"
	fi
}



function banips {

	iptables -N ocasofirewall &>/dev/null && iptables -A INPUT -j ocasofirewall
	for i in `cat /etc/hosts.deny | grep ^ALL: | cut -d" " -f2`; do
		banip $i
	done
}

function addIpToHostsDeny {
	BANED=`grep -c $1 /etc/hosts.deny`
	if [ $BANED -ge 1 ]
	then
		echo "This IP is in hosts.deny already."
	else
		echo "This IP is not in hosts.deny yet, adding..."
		echo "ALL: $1" >>/etc/hosts.deny
	fi
}

function checkip {
	echo "Looking for ip $1 on DNSBL sources. Wait..."
	NUM=`rblcheck $1 | grep -v "not listed by" | wc -l`
	if [ $NUM -ge 2 ];then
	        echo "Listed in SPAM LIST"

		addIpToHostsDeny $1
		banip $1
	else
	        echo "This ip is clean"
	fi
}

if [ -z $1 ];then
	echo -e "\nScript Writed by J.A. Nache <nache.nache@gmail.com>"
	echo    "Happy banning!!"
	echo -e "\n  Usage:"
	echo    "           $0 <ip>          Check if IP is on blacklist (DNSBL) and BAN!"
	echo    "           $0 -i            Just read /etc/hosts.deny and BAN! with iptables every IP"
	echo    "           $0 -f <ip>       Force add IP to hosts.deny and BAN! with iptables (and without DNSBL check)"
	echo -e "\n\n"
	exit 1
fi

if [ $1 = "-i" ]; then
	banips
elif [ $1 = "-f" ]; then
	addIpToHostsDeny $2
	banip $2
else
	checkip $1
fi
