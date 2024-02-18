# Demonstrating CAS Authentication from Apache to Keycloak

## Background

We are using the following Keycloak provider for CAS support:

* [jacekkow/keycloak-protocol-cas](https://github.com/jacekkow/keycloak-protocol-cas)

I have no reason to think this is a production ready tool,
but it is useful for understanding/testing the CAS protocol.

## Initialize Keycloak and OpenLDAP

Follow [Demonstrate LDAP Connection Between Keycloak and OpenLDAP](Demonstrate-LDAP-Connection-Between-Keycloak-and-OpenLDAP.md)

**NOTE**: It is important that the realm created in Keycloak (above)
is precisely named `SSO-Realm` for the apache2 configurations to function properly (below).

## Verify CAS via Apache2 (cas-proxy)

There are two sample pages in apache:

* Example Public Content: [https://cas-proxy.auth-demo.docker/index.php](https://cas-proxy.auth-demo.docker/index.php)
* Example Private Content: [https://cas-proxy.auth-demo.docker/secured-by-cas/index.php](https://cas-proxy.auth-demo.docker/secured-by-cas/index.php)

Open the second link

When prompted by Keycloak, login as `pswanson`, using the password from `authdemo-show-secrets.sh`

Confirm that you are able to see the **Example Private Content** page,
and that you see the following:

    Attributes Returned by CAS:

    REMOTE_USER = pswanson
