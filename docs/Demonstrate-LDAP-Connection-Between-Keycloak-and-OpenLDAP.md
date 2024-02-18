# Demonstrate LDAP Connection Between Keycloak and OpenLDAP

## Define an "SSO" Realm in KeyCloak

[Define an "SSO" Realm in Keycloak](Keycloak_Define-an-SSO-Realm-in-Keycloak.md)

## Add LDAP Connecton to Keycloak

[Add LDAP Connecton to Keycloak](Keycloak_Add-LDAP-Connecton-to-Keycloak.md)

## Verify LDAP Users Visible

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/),
then **Administration Console**, and then login as admin

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **Users** in the left panel, and then serach for `pswanson`

Confirm that `Peter Swanson` / `pswanson` is listed
