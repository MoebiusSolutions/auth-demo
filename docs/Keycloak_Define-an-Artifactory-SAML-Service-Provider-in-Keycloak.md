# Keycloak - Define an Artifactory SAML Service Provider in Keycloak

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `authdemo-show-secrets.sh`

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **Clients** in the left panel, and then click the **Create** button

Enter the following options on **Add client**, and then click **Save**:

* Client ID: `artifactory`
* Client Protocol: `saml`
* Client SAML Endpoint: `https://artifactory.proxy.auth-demo.docker/ui/api/v1/auth/saml/loginResponse`
    * NOTE: This is the endpoint used by Artifactory v7

After the page refreshes, update the following settings for the newly defined client,
and then click **Save**:

* Sign Assertions: `ON`
    * NOTE: Without this, Artifactory kicks out error: `... request validation failed: org.keycloak.common.VerificationException: SigAlg was null ... error=invalid_signature`
* Client Signature Required: `OFF`
    * NOTE: This is per the Artifactory documentation
* Valid Redirect URIs: `https://artifactory.proxy.auth-demo.docker/*`

