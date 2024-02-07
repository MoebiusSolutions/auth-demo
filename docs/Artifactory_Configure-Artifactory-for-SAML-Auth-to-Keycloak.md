# Artifactory - Configure Artifactory for SAML Auth to Keycloak

Open Artifactory at [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)
and login using the `Artifactory Admin` credentials from `authdemo-show-secrets.sh`

Click **Administration** (gears at the top right), then **Authentication Providers**,
then **SAML SSO**

On **SAML SSO Settings**, enter the following, and then click **Save**:

* `[✓]` Enable SAML Integration
* SAML Login URL: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm/protocol/saml`
* SAML Logout URL: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm/protocol/saml`
* SAML Service Provider Name: `artifactory`
* SAML Certificate: (loaded from Keycloak per the following)
    * In Keycloak, select the `SSO-Realm` realm, then the **Realm Settings** section,
      then the **Keys** tab
        * Click **Certificate** for the **RS256** key
* `[ ]` Use Encrypted Assertion
* `[ ]` Auto-Associate Groups
* Group Attribute: ``
* Email Attribute: ``
* `[✓]` Auto Create Artifactory Users
* `[✓]` Allow Created Users Access to Profile Page
* `[ ]` Auto Redirect Login Link to SAML Login
* `[ ]` Verify Audience Restriction

## Verify Ability to Login as LDAP Developer

Open Artifactory at [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)
and logout (if already logged in)

Clck on the `SAML SSO` button and logins as:

* Username: `pswanson`
* Password: (see output of `authdemo-show-secrets.sh` for Peter Swanson)


