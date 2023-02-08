# Azure - Added OAuth Token Claims to Azure AD for Bitbucket

We need access to more fields than are included by default in Azures ID/Access tokens.

Ensured that I had the `Demo AD` Tenant active (next to my name in the corner)

Opened the **Azure Active Directory** service inside the Azure Portal

Clicked **App Registrations**, then the **All applications** tab, then `Demo Bitbucket App`

Clicked **Token configuration** in the left panel

Clicked **Add optional claim** under **Optional claims**

Selected **ID**, then enabled the following and clicked **Add**

* `[✓]` **email**
* `[✓]` **family_name**
* `[✓]` **given_name**

When promted by the following:

> Some of these claims (email, `family_name`, `given_name`) require OpenId Connect scopes
> to be configured through the API permissions page or by checking the box below.
> 

... I enabled the option and clicked **Add**:

* `[✓]` **Turn on the Microsoft Graph email, profile permission (required for claims to appear in token)**
