# Demonstrating Artifactory Authentication through SAML to Keycloak

## Initialize Keycloak and OpenLDAP

[Demonstrate LDAP Connection Between Keycloak and OpenLDAP](Demonstrate-LDAP-Connection-Between-Keycloak-and-OpenLDAP.md)

## Initialize Artifactory

[Initialize Artifactory](Artifactory_Initialize-Artifactory.md)

## Configure SAML in Keycloak

[Define an Artifactory SAML Service Provider in Keycloak](Keycloak_Define-an-Artifactory-SAML-Service-Provider-in-Keycloak.md)

## Configure SAML in Artifactory

[Configure Artifactory for SAML Auth to Keycloak](Artifactory_Configure-Artifactory-for-SAML-Auth-to-Keycloak.md)

## Verify Ability to Login as LDAP Developer

Open Artifactory at [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)
and logout (if already logged in)

Clck on the **SAML SSO** button and logins as:

* Username: `pswanson`
* Password: (see output of `authdemo-show-secrets.sh` for Peter Swanson)


