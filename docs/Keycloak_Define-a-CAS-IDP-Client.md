# Keycloak - Define a CAS IDP (Client) in Keycloak

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `authdemo-show-secrets.sh`

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **Clients** in the in the left panel, then click **Create client**

Enter the following options on **Create client**, and then click **Save**:

* General settings
    * **Client type**: `cas`
    * **Client ID**: `Demo CAS`
        * NOTE: This field is effectively meaningless
          since the CAS provider identifies the
          CAS client by matching redirect URL
* Capability config
    * NOTE: This page is blank
* Login settings
    * **Valid redirect URIs**:
        * `https://cas-proxy.auth-demo.docker/*`
            * NOTE: This is our demo Apache2 server,
              which is configured to use Keycloak CAS
