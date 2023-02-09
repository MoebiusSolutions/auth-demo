# Demonstrating Group Sync and JIT User Provisioning in Artifactory via SAML to Azure AD

## Overview

This is very similar to
[Demonstrating Group Sync and JIT User Provisioning in Bitbucket via SAML to Azure AD](docs/Demonstrating-Group-Sync-and-JIT-User-Provisioning-in-Bitbucket-via-SAML-to-Azure-AD.md),
so I am only covering the Artifactory-specific steps in this document.

## A Word About Group Membership via SAML Tokens

Ah, the **Auto Associate Groups** option has this help text:

> When set, in addition to the groups the user is already associated with, he will also be associated with the
> groups returned in the SAML login response. Note that the user's association with the returned groups is not
> persistent. It is only valid for the current login session.

... so we won't see the group membership in the Admin UI. We only see the effects of it.

## Initialized Artifactory

[Initialize Artifactory](Artifactory_Initialize-Artifactory.md)

## Setup Enterprise Application for Artifactory with SAML SSO in in Azure

This is basically the same as was done for Bitbucket, except for these settings:

* **Identifier (Entity ID)**: `https://artifactory.proxy.auth-demo.docker/`
* **Reply URL (Assertion Consumer Service URL)**: `https://artifactory.proxy.auth-demo.docker/artifactory/webapp/saml/loginResponse`
* **Sign on URL (Optional)**: `https://artifactory.proxy.auth-demo.docker/ui/login`

We do setup the same Group Claim as did for Bitbucket, which uses a **Source attribute** of `Group ID`.

## Setup SAML SSO in Artifactory

With `All` selected at the top, I opened the **Administation** (gear icon) panel,
then **Authentication Providers**, then **SAML SSO**

I entered the following and clicked **Save**:

* **Enable SAML Integration**: `[✓]`
* **SAML Login URL**: The **Logout URL** from the Enterprise Application in Azure AD
    * Format: `https://login.microsoftonline.com/<tenant-id>/saml2`
* **SAML Logout URL**: The **Login URL** from the Enterprise Application in Azure AD
    * Format: `https://login.microsoftonline.com/<tenant-id>/saml2`
* **SAML Service Provider Name**: The **Identifier (Entity ID)** we provided to Azure.
    * Value: `https://artifactory.proxy.auth-demo.docker/`
* **SAML Certificate**: The **Certificate (Base64)** from the Enterprise Application in Azure AD
* **Use Encrypted Assertion**: `[_]`
    * **TODO**: Experiment with this
* **Auto Associate Groups**: `[✓]`
* **Group Attribute**: `http://schemas.microsoft.com/ws/2008/06/identity/claims/groups`
* **Email Attribute**: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`
* **Auto Create Artifactory Users**: `[✓]`
* **Allow Created Users Access to Profile Page**: `[✓]`
* **Auto Redirect Login Link to SAML Login**: `[_]`
    * This would prevent direct admin logins
* **Verify Audience Restriction**: `[_]`

## Setup Users and Groups in Azure

[Define Standard Users and Groups in Azure AD](Azure_Define-Standard-Users-and-Groups-in-Azure-AD.md)

## Defined User Groups in Artifactory

Used the **Add new group** tool to define the following user groups:

* **Group name**: `projecta-read`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projecta-write`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projecta-admin`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projectb-read`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projectb-write`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projectb-admin`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projectc-read`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projectc-write`
    * **External ID**: (group UUID from Azure AD)
* **Group name**: `projectc-admin`
    * **External ID**: (group UUID from Azure AD)

## Defined Projects in Artifactory

Used the **Create new** button to define the following projects:

* **Name**: `Project A`
    * **Project Key**: `projecta` 
    * **Project Admins**:
        * **Groups**: `projecta-admin`
* **Name**: `Project B`
    * **Project Key**: `projectb` 
    * **Project Admins**:
        * **Groups**: `projectb-admin`
* **Name**: `Project C`
    * **Project Key**: `projectc` 
    * **Project Admins**:
        * **Groups**: `projectc-admin`

## Granted Group Permissions in Artifactory

From the context of each project, cliced **User Management**, then **Add Members**,
and added the following group/role combinations:

* Project: `Project A`
    * Group/role combinations:
        * `projecta-read` / `Viewer`
        * `projecta-write` / `Developer`
* Project: `Project B`
    * Group/role combinations:
        * `projectb-read` / `Viewer`
        * `projectb-write` / `Developer`
* Project: `Project C`
    * Group/role combinations:
        * `projectc-read` / `Viewer`
        * `projectc-write` / `Developer`

## Verified Login/Permissions

I was able to use the **SAML SSO** button to login to Artifactory as `first.user`

I was able to access Project A and Project C, but not Project B

I was able to access the admin panel of Project A only
