# Setup - Initialize Keycloak

## Define an "SSO" Realm in KeyCloak

NOTE: We do this because it is not recommended to put non-admin users in the Master realm.

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `show-secrets.sh`

Hover over the current Realm (`Master`) in the left panel--until **Add Realm** appears

Click **Add Realm**

Enter the following under **Add realm** and click **Create**

* Name: `SSO-Realm`
* Enabled: `ON`

## Add LDAP Connecton to Keycloak

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `show-secrets.sh`

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **User Federation** in the left panel, and then select **ldap**

Enter the following options on **Add use federation provider**, and then click **Save**:

* Console Display Name: `Demo LDAP`
* Import Users: `ON`
* Edit Mode: `READ_ONLY`
* Vendor: `Other`
* Username LDAP attribute: `uid` (NOTE: the OpenLDAP UI has this as an alias to `User Name`)
* RDN LDAP attribute: `uid`
* UUID LDAP attribute: `uidNumber`
    * NOTE: This is not a UUID, but I believe it is unique enough in our OpenLDAP config
      to be unique across all users
* User Object Classes: `inetOrgPerson, organizationalPerson`
* Connection URL: `ldap://ldap:389/`
    * Click **Test connection** button
* Users DN: `dc=example,dc=com`
* Bind Type: `simple`
* Bind DN: `cn=ldap-bind,dc=example,dc=com`
* Bind Credential: (see `show-secrets.sh` output for `LDAP Bind`)
    * Click **Test authentication** button

Click **Synchronize all users** at the bottom of the page

## Verify LDAP Users Visible

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/),
then **Administration Console**, and then login as admin

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **Users** in the left panel, and then click **View all users**

Confirm that `Peter Swanson` / `pswanson` is listed
