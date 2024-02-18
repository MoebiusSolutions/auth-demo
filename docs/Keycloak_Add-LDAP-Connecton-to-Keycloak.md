# Keycloak - Add LDAP Connecton to Keycloak

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `authdemo-show-secrets.sh`

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **User Federation** in the left panel, and then select **Add Ldap providers**

Enter the following options on **Add LDAP provider**, and then click **Save**:

* General options
    * UI display name: `Demo LDAP`
    * Vendor: `Other`
* Connection and authentication settings
    * Connection URL: `ldap://ldap:389/`
        * Click **Test connection** button

    * Bind Type: `simple`
    * Bind DN: `cn=ldap-bind,dc=example,dc=com`
    * Bind Credential: (see `authdemo-show-secrets.sh` output for `LDAP Bind`)
        * Click **Test authentication** button
* LDAP searching and updating
    * Edit Mode: `READ_ONLY`
    * Users DN: `dc=example,dc=com`
    * Username LDAP attribute: `uid`
    * RDN LDAP attribute: `uid`
    * UUID LDAP attribute: `uidNumber`
        * NOTE: This is not a UUID, but I believe it is unique enough in our OpenLDAP config
        to be unique across all users
    * User Object Classes: `inetOrgPerson, organizationalPerson`

Open the newly created `Demo LDAP` item, click **Action** (upper right), and then click **Sync all users**
