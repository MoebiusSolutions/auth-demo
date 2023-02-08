# Demonstrating Group Sync and JIT User Provisioning in Bitbucket via SAML to Azure AD

## Overview

This demonstrates:

* Group membership being communicated solely through SAML (no LDAP/AD sync of groups)
* JIT provisioning of the user


## A Word on Azure Groups through SAML

Per [this](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-fed-group-claims),
Azure will only use groups by name (versus UUID) SAML claims if:

* The groups were synced from an AD server to Azure AD (not us)
* The groups are defined in the Enteprise Application, not the global Azure AD Tenant
    * I cannot use this configuration in the free version of Azure AD,
      and I am unsure how COSMOS is defining groups

Bitbucket seems functional enough using UUIDs instead of human readable names,
it just makes auditing of groups via Bitbucket a bit combersome.


## Initialized Bitbucket

Followed [Initialize Bitbucket](docs/Bitbucket_Initialize-Bitbucket.md)


## Azure AD "App Registration" vs "Enterprise Application"

It looks like we can define an application via either "App Registration"
or "Enterprise Application", but the latter seems to provide a much more guided process.

Note that creating an object in either tool will populate the other,
but an Enterprise Application appears does not appear under the "Owned"
tab (default) of App Registrations.

In the end I was able to get OIDC working through a standard App Registration,
but I struggled to get SAML working until I switched over to using the
Entprise Application wizard.


## Captured the SAML URLs for Bitbucket

In Bitbucket, opened **Administration** (gear icon)

Clicked **Authentication Methods** in the left panel, then clicked **Add configuration**

Entered the following into **Add new configuration**:

* **Name**: (blank)
* **Authentication method**: `SAML single sign-on`

Saved a copy of the the following two URLs

* **Assertion Consumer Service URL**
* **Audience URL (Entity ID)**


## Exposed Azure AD to to Bitbucket, through SAML

NOTE: the following was derived from
[this guide](https://confluence.atlassian.com/jirakb/how-to-configure-saml-authentication-with-azure-active-directory-on-jira-data-center-1082272116.html).

Ensured that I had the `Demo AD` Tenant active (next to my name in the corner)

Opened the **Azure Active Directory** service inside the Azure Portal

Clicked **Enterprise Applications**, then the **New application** button,
then the **Create your own application** button

Entered the following and clicked the **Create** button:

* What's the name of your app: `Demo Bitbucket SAML EA` (Enterprise Application)
* What are you looking to do with your application:
  `Integrate any other application you don't find in the gallery (Non-gallery)`

From the the `Demo Bitbuket SAML EA` Enterprise Application page,
clicked the **Single sing-on** in the left panel, then **SAML**

Clicked **Edit** next to **Basic SAML Configuration**

Entered the following and then clicked **Save**:

* **Identifier (Entity ID)**: (The **Audience URL (Entity ID)** from Bitbucket)
    * For example: `https://bitbucket.proxy.auth-demo.docker`
* **Reply URL (Assertion Consumer Service URL)**: (The **Assertion Consumer Service URL** from Bitbucket)
    * For example: `https://bitbucket.proxy.auth-demo.docker/plugins/servlet/samlconsumer`

From the the `Demo Bitbuket SAML EA` Enterprise Application page,
clicked the **Properties** in the left panel

Entered the following and clicked **Save**:

* ***Assignment required?**: `No`
    * This allows all users in the AD Tenant to be authorized through this SAML enpoint

From the the `Demo Bitbuket SAML EA` Enterprise Application page,
clicked the **Single sing-on** in the left panel, then **SAML**

Clicked **Edit** next to **Attributes & Claims**

Clicked the **Add a group claim** button

Entered the following and clicked **Save**:

* **Which groups associated with the user should be returned in the claim?**: `All groups`
* **Source attribute**: `Group ID`

From the the `Demo Bitbuket SAML EA` Enterprise Application page,
clicked the **Single sing-on** in the left panel, then **SAML**

Kept this page open for reference when configuring Bitbucket


## Added Azure AD SAML to Bitbucket

In Bitbucket, opened **Administration** (gear icon)

Clicked **Authentication Methods** in the left panel, then clicked **Add configuration**

Entered the following into **Add new configuration** and then clicked **Save Configuration**

* **Name**: `Demo Azure SAML`
* **Authentication method**: `SAML single sign-on`
* **Single sign-on issuer**: (the **Azure AD Identifier** from Azure AD)
    * To get the Azure AD Identifier:
        * Open the `Demo Bitbucket SAML EA` Enterprise Application
        * Click **Single sign-on** in the left panel
        * Scroll to the **Set up Demo Bitbucket SAML EA** section
    * Format of the URL: `https://sts.windows.net/<tenant-id>/`
* **Identity provider single sign-on URL**: (the **Login URL** from Azure AD)
    * To get the Login URL:
        * Open the `Demo Bitbucket SAML EA` Enterprise Application
        * Click **Single sign-on** in the left panel
        * Scroll to the **Set up Demo Bitbucket SAML EA** section
    * Format of the URL: `https://login.microsoftonline.com/<tenant-id>/saml2`
* **X.509 Certificate**: (the base64-encoded certificate from Azure AD)
    * To get the base64-encoded certificate:
        * Open the `Demo Bitbucket SAML EA` Enterprise Application
        * Click **Single sign-on** in the left panel
        * Scroll to the **SAML Certificates** section
        * Click **Download** next to **Certifcate (Base64)**
* **Username mapping**: `${NameID}`
* **Create users on login to the application**: `[✓]`
    * These come from the **Attributes & Claims** section of the **Single sign-on** section of the `Demo Bitbucket SAML EA` Enterprise Application
    * **Display name**: `${http://schemas.microsoft.com/identity/claims/displayname}`
    * **Email**: `${http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress}`
    * **Groups**: `http://schemas.microsoft.com/ws/2008/06/identity/claims/groups`
* **Remember user logins**: `[_]`
* **Show IdP on the login page**: `[✓]`
* **Login button text**: `Demo Azure SAML SSO`


## Granted Azure Group ID Access to Bitbucket

At this point I tried logging into a user defined in Azure AD, that was also a member of the `stash-users` group in AD.

This caused the user to be created in Bitbucket, as well as a group with the name of the UUID of the `stash-users` group in AD.

From **Global permissions** of Bitbucket, I granted this new group **Bitbucket user** permissions,
and then the user was able to access Bitbucket.
