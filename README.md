# DNS-LDAsPirateur
Outils pour récupérer tous les entregistrements DNS d'un DNS intégré à l'Active Directory
## installation :
il faut installer le paquet de votre distribution offrant ldapsearch
## utilisation :
```
./dns_ldaspirateur -h <ip/fqdn AD> -u <utilisateurAD> -p '<passwordAD>'
```
le résultat donne tous les FQDNs hebergé par le DNS du controleur de dommain pour toutes les zones qu'il héberge.
