# DNS-LDAsPirateur

Outils pour récupérer tous les entregistrements DNS d'un DNS intégré à l'Active Directory

## Installation :

Pour utiliser cet outil, il faut installer le paquet de votre distribution offrant la commande `ldapsearch`

 + Sur **Ubuntu**: `apt install ldapscripts`

## utilisation :
```
./DNS-LDAsPirateur.sh -h <ip/fqdn AD> -u <utilisateurAD> -p '<passwordAD> -d <DC domain>'
```
Il faut adapté votre domain pour l'argument -d :

si votre domain est : 

   **ad.zone.local** 
   
il faut mettre : 

   **DC=ad,DC=zone,DC=local**


le résultat donne tous les FQDNs hebergé par le DNS du controleur de dommain pour toutes les zones qu'il héberge.
