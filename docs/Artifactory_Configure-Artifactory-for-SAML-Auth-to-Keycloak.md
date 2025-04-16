# Artifactory - Configure Artifactory for SAML Auth to Keycloak

Open Artifactory at [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)
and login using the `Artifactory Admin` credentials from `authdemo-show-secrets.sh`

Click **Administration** (gears at the top right), then **Authentication**,
then **SAML SSO**

Toggle **SAML SSO** to `On`

Click **Add SAML SSO Configuration**

Enter the following then

On **SAML SSO Configuration**, enter the following, and then click **Save**:

* `[✓]` Enable SAML Integration
* Display Name: `keycloak`
* SAML Login URL: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm/protocol/saml`
    * NOTE: The [JFrog SAML Guide](https://jfrog.com/help/r/jfrog-platform-administration-documentation/saml-sso-configuration-with-keycloak)
      has a typo on this item
* SAML Logout URL: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm/protocol/saml`
    * NOTE: The [JFrog SAML Guide](https://jfrog.com/help/r/jfrog-platform-administration-documentation/saml-sso-configuration-with-keycloak)
      has a typo on this item
* SAML Service Provider Name: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm`
    * NOTE: See [Artifactory - "SAML Service Provider" Confusion](Artifactory_SAML-Service-Provider-Confusion.md) as to "why"
* SAML Certificate: (loaded from Keycloak per the following)
    * In Keycloak, select the `SSO-Realm` realm, then the **Realm Settings** section,
      then the **Keys** tab
        * Click **Certificate** for the **RS256** key

* `[ ]` Use Encrypted Assertion
* `[ ]` Auto-Associate Groups
* Group Attribute: (blank)
* Email Attribute: (blank)
* `[✓]` Auto Create Artifactory Users
* `[✓]` Allow Created Users Access to Profile Page
* `[ ]` Auto Redirect Login Link to SAML Login

## Verify Ability to Login as LDAP Developer

Open Artifactory at [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)
and logout (if already logged in)

Clck on the `SAML SSO` button and logins as:

* Username: `pswanson`
* Password: (see output of `authdemo-show-secrets.sh` for Peter Swanson)


