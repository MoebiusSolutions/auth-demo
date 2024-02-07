# Demonstrate Bitbucket Authentication through Crowd/LDAP to Keycloak/OpenLDAP

## Setup Keycloak/OpenLDAP

[Demonstrate LDAP Connection Between Keycloak and OpenLDAP](Demonstrate-LDAP-Connection-Between-Keycloak-and-OpenLDAP.md)

## Provision Crowd

[Initialize Crowd](Crowd_Initialize-Crowd.md)

## Add LDAP Connector to Crowd

[Add LDAP Connector to Crowd](Crowd_Add-LDAP-Connector-to-Crowd.md)

## Add Bitbucket Application to Crowd

[Add Bitbucket Application to Crowd](Crowd_Add-Bitbucket-Application-to-Crowd.md)

## Initialize Bitbucket

[Initialize Bitbucket](Bitbucket_Initialize-Bitbucket.md)

## Add Crowd Directory to Bitbucket

[Add Crowd Directory to Bitbucket](Bitbucket_Add-Crowd-Directory-to-Bitbucket.md)

## Grant Keycloak LDAP Group Access to Bitbucket

[Grant LDAP Group Access to Bitbucket](Bitbucket_Grant-LDAP-Group-Access-to-Bitbucket.md)

## Verify Ability to Login as LDAP Developer

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/)
and logout (if already logged in)

Login as:

* Username: `pswanson`
* Password: (see output of `authdemo-show-secrets.sh` for Peter Swanson)
