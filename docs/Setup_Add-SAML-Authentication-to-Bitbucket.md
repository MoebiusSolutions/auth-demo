# Setup - Add SAML Authentication to Bitbucket

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/) and login as the admin

Open **Administration** (gear icon)

Click **Authentication Methods** in the left panel, then click **Add configuration**

Enter the following into **Add new configuration** and then click **Save Configuration**

* Name: `SAML-SSO`
* Authentication method: `SAML single sign-on`
* Single sign-on issuer: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm`
    * (This is the `entityID` attribute of the `/EntityDescriptor` element of the IDP Metadata XML downloaded from Keycloak)
* Identity provider single sign-on URL: `https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm/protocol/saml`
    * (This is the `Location` attribute of the `/EntityDescriptor/IDPSSODescriptor/SingleLogoutService` element of the IDP Metadata XML downloaded from Keycloak)
* X.509 Certificate: (The body of the `/EntityDescriptor/IDPSSODescriptor/KeyDescriptor/KeyInfo/X509Data/X509Certificate` element of the IDP Metadata XML downloaded from Keycloak)
* Username mapping: `${NameID}`
* Show IdP on the login page: `[✓]`
* Login button text: `Demo Keycloak SAML SSO`

Make a mental note of these fields from the newly created Authentcation entry:

* Assertion Consumer Service URL
* Audience URL (Entity ID)

... You will need these when configuring a **Client** in Keycloak.