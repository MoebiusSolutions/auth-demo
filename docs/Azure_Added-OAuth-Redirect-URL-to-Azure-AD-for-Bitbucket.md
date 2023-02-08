# Azure - Added OAuth Redirect URL to Azure AD for Bitbucket

Ensured that I had the `Demo AD` Tenant active (next to my name in the corner)

Opened the **Azure Active Directory** service inside the Azure Portal

Clicked **App Registrations**, then the **All applications** tab, then `Demo Bitbucket App`

Clicked **Add a Redirect URI** under the **Essentials** section

Clicked **Add a platform** under **Platform Configurations**, then clicked **Web**

Entered the following:

* **Redirect URIs**: `https://bitbucket.proxy.auth-demo.docker/plugins/servlet/oidc/callback`
    * (This is the **Redirect URL** of the **Authentication Method** we defined in Bitbucket)
* **Front-channel logout URL**: (blank)
* **Select the tokens you would like to be issued by the authorization endpoint**:
    * `[✓]`: **Access tokens**
    * `[✓]`: **ID tokens**
    * (Unsure if these are needed)