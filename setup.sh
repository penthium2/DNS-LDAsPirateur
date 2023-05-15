#!/usr/bin/env bash

function os_identifier() {
    local os_id=$(cat /etc/os-release | awk '$1 ~ /^ID=/' | awk -F'=' '{print $2}')
    case ${os_id} in
        debian)
            OS="debian-like"
            PACKAGES+=(ldap-utils)
        ;;
        ubuntu)
            OS="debian-like"
            PACKAGES+=(ldap-utils)
        ;;
        fedora)
            OS="centos-like"
            PACKAGES+=(openldap-clients)
        ;;
        *centos*)
            OS="centos-like"
            PACKAGES+=(openldap-clients)
        ;;
        alpine)
            OS="alpine"
            PACKAGES+=(openldap-clients)
        ;;
        *)
            echo "[!] OS ID not find."
            exit 1
        ;;
    esac
}

function package_statut() {
    for package in ${!PACKAGES[@]}; do
        local status=$(command -v ${PACKAGES[$package]})
        if [ -z ${status} ]; then
            [[ ${OS} == "debian-like" ]] && apt -qq install -y ${PACKAGES[$package]} 
            [[ ${OS} == "centos-like" ]] && yum install -y -q ${PACKAGES[$package]} 
            [[ ${OS} == "alpine" ]] && apk add --quiet ${PACKAGES[$package]}
            #if [[ $? != 0 ]]; then
            #    echo "[!] error package download"
            #    exit 1
            #fi
        fi
        
        echo "      [DONE] ${PACKAGES[$package]} installed"
    done
}

echo "[+] Install DNS-LDAsPirateur.sh - by penthium2"
echo "[+] Check package needed..."

declare -A $PACKAGES

os_identifier

PACKAGES+=(grep sed)
package_statut

echo "[+] DNS-LDAsPirateur.sh is ready !"