# Bitbucket - Added Azure AD OAuth to Bitbucket

In Bitbucket, opened **Administration** (gear icon)

Clicked **Authentication Methods** in the left panel, then clicked **Add configuration**

Entered the following into **Add new configuration** and then clicked **Save Configuration**

* **Name**: `Demo Azure OAuth`
* **Authentication method**: `OpenID Connect single sign-on`
* **Issuer URL**: (the base URL of **OpenID Connect metadata document** the Azure endpoint, with a format of `https://login.microsoftonline.com/00000000-0000-0000-0000-000000000000/v2.0`)
    * To get to the endpoint URLs in Azure:
        * Click the **Endpoints** button at the top of the **Overview** page of of the **App Registration**
* **Client ID**: (the **Application (client) ID** from the top of the **Overview** page of of the **App Registration**, with format `00000000-0000-0000-0000-000000000000`)
* **Username mapping**: `${email}`
    * NOTE: Microsoft recommends you do NOT use email (or any other human readable string) as a user ID,
      but we are starting with this because it's predictable (I can manually create a user with the associated user ID).
      See the **A Discussion of User IDs** section above for more info.
* **Additional scopes**: `email`
    * **TODO**: Is this necessary to have the email address come through?
    * NOTE: "Claims" are essentially data fields in a identity token, and "Scopes" are essentially groups of these fields
    * NOTE: [This](https://learn.microsoft.com/en-us/azure/active-directory/develop/scopes-oidc#openid-connect-scopes) documents the Scopes available in Azure
* **Fill the data automatically from my chosen identity provider**: `[✓]`
* **Create users on login to the application**: `[_]`
* **Show IdP on the login page**: `[✓]`
* **Login button text**: `Demo Azure OAuth SSO`
