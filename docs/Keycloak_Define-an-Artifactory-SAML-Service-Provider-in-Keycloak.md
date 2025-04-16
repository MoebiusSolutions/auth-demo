# Keycloak - Define an Artifactory SAML Service Provider in Keycloak

NOTE: The [JFrog SAML Guide](https://jfrog.com/help/r/jfrog-platform-administration-documentation/saml-sso-configuration-with-keycloak)
has a fairly good setup guide for Keycloak and Artifactory
(with only a few typos).

Open Keycloak at [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)

Click **Administration Console**, and login using the `Keycloak Admin` credentials from `authdemo-show-secrets.sh`

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **Clients** in the left panel, and then click the **Create client** button

Enter the following options on **Create client**, and then click **Next**:

* Client type: `SAML`
* Client ID: `https://artifactory.proxy.auth-demo.docker`
    * NOTE: Artifactory no longer allows an arbitrary client ID--it must match its own hostname.
      See [Artifactory - "SAML Service Provider" Confusion](Artifactory_SAML-Service-Provider-Confusion.md).
* Name: (blank)
* Description: (blank)
* Always display in UI: `On`

Enter the following options on **Create client** (page 2), and then click **Save**:

* Root URL: `https://artifactory.proxy.auth-demo.docker/ui/api/v1/auth/saml/loginResponse/keycloak`
* Home URL: `https://artifactory.proxy.auth-demo.docker/ui/api/v1/auth/saml/loginResponse/keycloak`
* Valid redirect URIs: `https://artifactory.proxy.auth-demo-2.docker/*`

After the page refreshes, update the following settings for the newly defined client,
and then click **Save**:

* **Settings** tab
    * **Signature and Encryption** section
        * Sign Assertions: `On`
            * NOTE: Without this, Artifactory kicks out error: `... request validation failed: org.keycloak.common.VerificationException: SigAlg was null ... error=invalid_signature`
    * **SAML capabilities** section
        * Force POST Binding: `Off`
    * **Logout settings** section
        * Front Channel Logout: `Off`
* **Keys** tab
    * **Signing keys config** section
        * Client signature required: `Off`

