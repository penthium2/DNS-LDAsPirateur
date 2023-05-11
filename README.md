# DNS-LDAsPirateur

Outils pour récupérer tous les entregistrements DNS d'un DNS intégré à l'Active Directory

## Installation :

Pour utiliser cet outil, il faut installer le paquet de votre distribution offrant la commande `ldapsearch`

 + Sur **fedora**: `dnf install openldap-clients`
 + Sur **Ubuntu**: `apt install ldapscripts`

## Utilisation :

```
./DNS-LDAsPirateur.sh -h <ip/fqdn AD> -u <utilisateurAD> -p '<passwordAD> -d <DC domain>'
```

En sortie ce script liste tous les Fully Qualified Domain Names (FQDNs) inscrits dans le DNS du contrôleur de domaine pour toutes les zones qu'il héberge.
