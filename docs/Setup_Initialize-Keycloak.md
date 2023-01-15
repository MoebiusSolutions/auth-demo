# Setup - Initialize Keycloak

## Add LDAP Connecton to Keycloak

Open Keycloak at [http://keycloak.auth-demo.docker:8080/](http://keycloak.auth-demo.docker:8080/)

Click **Administration Console**, and login with the `Keycloak Admin` credentials from `show-secrets.sh`

Click **User Federation** in the left panel, and then select **ldap**

Enter the following options on **Add use federation provider**, and then click **Save**:

* Console Display Name: `Demo OpenLDAP`
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

Open Keycloak at [http://keycloak.auth-demo.docker:8080/](http://keycloak.auth-demo.docker:8080/),
then **Administration Console**, and then login as admin

Click **Users** in the left panel, and then click **View all users**

Confirm that `Peter Swanson` / `pswanson` is listed

