#!/bin/bash
# Method for animation while script is working:
# to call it, use : spinner & ; pidspin=$(jobs -p) ; disown
spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}
# Method to kill the animation :
killspinner() {
kill $pidspin 
printf "\n"
}


echo "[+] DNS-LDAsPirateur.sh - by penthium2"
echo ""

results_per_page=10000
if [[ -z "${1}" ]] ; then
	echo "DNS-LDAsPirateur.sh -h <ip/fqdn AD> -u <utilisateurAD> -p '<passwordAD>' -d <DC domain>"
	exit 2
fi
while [[ -n "${1}" ]] ; do
	case $1 in
		-h|--host)
        		ldap="${2}"
			shift 2
			;;
		-u|--user)
			user="${2}"
			shift 2
			;;
		-p|--password)
			password="${2}"
			shift 2
			;;
		-d|-domain)
			domain="${2}"
			shift 2
			;;
		--help)
			echo "DNS-LDAsPirateur.sh -h <ip/fqdn AD> -u <utilisateurAD> -p '<passwordAD>' -d <DC domain>"
			exit 0
			;;
		*)
			echo "Unknown option '${1}'"
			exit 2
			;;
	      esac
done
if [[ -z "${ldap}" || -z "${user}" || -z "${password}" || -z "${domain}" ]] ; then
	echo "DNS-LDAsPirateur.sh -h <ip/fqdn AD> -u <utilisateurAD> -p '<passwordAD>' -d <DC domain>"
	exit 1
fi
# Format the domain
domain="DC="$(echo "${domain}" | sed 's/\./,DC=/g')
printf  "Aspiration en cours : "
spinner &
pidspin=$(jobs -p)
disown
ldapsearch -Q -LLL -H "ldap://${ldap}:389" -b "CN=MicrosoftDNS,DC=DomainDnsZones,${domain}" -w "${password}" -U "${user}" '(objectClass=dnsNode)' -E pr=${results_per_page}/noprompt \
 | grep -A 1 '^dn:' \
 | sed -nE '/--/d;s/dn: DC=(.*)CN=MicrosoftDNS.*$/\1/;s/^([^,]+),DC=([^,]+),$/\1.\2/p'
killspinner