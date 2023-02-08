# Keycloak - Define an "SSO" Realm in Keycloak

NOTE: We do this because it is not recommended to put non-admin users in the Master realm.

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `authdemo-show-secrets.sh`

Hover over the current Realm (`Master`) in the left panel--until **Add Realm** appears

Click **Add Realm**

Enter the following under **Add realm** and click **Create**

* Name: `SSO-Realm`
* Enabled: `ON`
