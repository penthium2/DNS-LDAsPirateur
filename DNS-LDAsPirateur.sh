#!/bin/bash
while [[ -n "$1" ]] ; do
	case $1 in
		-h|--host)
        		ldap="$2"
			shift 2
			;;
		-u|--user)
			user="$2"
			shift 2
			;;
		-p|--password)
			password="$2"
			shift 2
			;;
		-d|-domain)
			domain=$2
			shift 2
			;;
		*)
			echo "synthax error"
			exit 2
			;;
	      esac
done

ldapsearch -LLL -H ldap://${ldap}:389 -b "CN=MicrosoftDNS,DC=DomainDnsZones,${domain}"  -w "${password}" -U "${user}" '(objectClass=dnsNode)' -E pr=10000/noprompt | grep -A 1 '^dn:' | sed -nE '/--/d;s/dn: DC=(.*)CN=MicrosoftDNS.*$/\1/;s/^([^,]+),DC=([^,]+),$/\1.\2/p'
