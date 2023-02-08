# Demonstrating OAuth from Bitbucket to Azure Active Directory

## Overview

This is a demonstration of an Atlassian product (Bitbucket) executing SSO against Azure Active Directory, over OAuth.

## A Discussion of User IDs

In the procedure that follows, I use the `email` field as a user ID.
This allows us to get up and running quickly, but this is not ideal.

Microsoft outlines recommendations
[here](https://learn.microsoft.com/en-us/azure/active-directory/develop/id-tokens#using-claims-to-reliably-identify-a-user-subject-and-object-id).

In summary:

* User IDs should not be human-predictable, but instead GUIDs
    * Why:
        * Anything human-predictable/readable (name/email/etc) is also human-modifiable,
          so users could lose control of their account when modified,
          or users could take over other user's accounts on rename collisions
        * Anything human-predictable/readable causes collisions across domain contexts
            * The same email in different Azure Tenants (think unique Active Directory servers)
              represents a different account
            * This gets worse with simple usernames
    * Problem for us: Bitbucket needs a username, and it's very odd to not have a meaningful one
        * Maybe another Bitbucket SSO Plugin (`re:solution` or `miniorange`) would allow us to define a richer mapping logic
          (identify user via UID but use something else a username)
        * Maybe having an LDAP connection in addition to the SSO would allow us to define a richer mapping logic
          (automatically identify user via UID but use something else a username)
    * Problem for us: If we use an Azure-originated GUID, we can only pre-provision users with queries to Azure
        * We could experiment with the JIT Provisioning feature of Bitbucket Authentication Methods

That being said, here are the fields that Azure provides:

* `${sub}`:
    * This is a UID that uniquely identifies the combination of:
        * Azure User
        * "client" (App Registration within Azure I believe)
        * Azure Tenant
    * This is not an ideal UID because we want a UID that works across App Registrations
    * I'm not sure how you deterministically generate this for a given user (I was only able to capture the raw value in error logs in Bitbucket)
* `${oid}`: The UUID of the Azure User
* `${tid}`: The UUID of the Azure Tenant

It looks like the best non-human readable GUID might be: `${tid}-${oid}`

## A Common bitbucket Red Herring Error

I saw this error frequently:

    ... Unknown state in response ...

... but I believe it is a red herring, from this pattern of execution:

1. We fail to login and get kicked to an error page
2. We attempt to login again (by clicking the "login" button),
   which tells the webpage to redirect back to this page after logging in
3. We successfully login, and Bitbucket redirects back to the error page,
   but the error page is not actually relevant to our current (successfully authentiated) session

## Initialized Azure

[Setup a Account and Tenant in Azure](Azure_Setup-a-Account-and-Tenant-in-Azure.md)

## Initialized Bitbucket

[Initialize Bitbucket](Bitbucket_Initialize-Bitbucket.md)

## Defined Bitbucket OAuth Client Secret in Azure AD

[Defined Bitbucket OAuth Client Secret in Azure AD](Azure_Defined-Bitbucket-OAuth-Client-Secret-in-Azure-AD.md)

## Exposed Azure AD through OAuth

[Exposed Azure AD to Bitbucket through OAuth](Azure_Exposed-Azure-AD-to-Bitbucket-through-OAuth.md)

## Added Azure AD OAuth to Bitbucket

[Added Azure AD OAuth to Bitbucket](Bitbucket_Added-Azure-AD-OAuth-to-Bitbucket.md)

## Added OAuth Redirect URL to Azure AD for Bitbucket

[Added OAuth Redirect URL to Azure AD for Bitbucket](Azure_Added-OAuth-Redirect-URL-to-Azure-AD-for-Bitbucket.md)

## Added OAuth Token Claims to Azure AD for Bitbucket

[Added OAuth Token Claims to Azure AD for Bitbucket](Azure_Added-OAuth-Token-Claims-to-Azure-AD-for-Bitbucket.md)

## Defined User and Group in Azure AD for Bitbucket OAuth 

[Defined User and Group in Azure AD for Bitbucket OAuth](Azure_Defined-User-and-Group-in-Azure-AD-for-Bitbucket-OAuth.md)

## Defined User in Bitbucket for Azure AD OAuth

[Defined User in Bitbucket for Azure AD OAuth](Bitbucket_Defined-User-in-Bitbucket-for-Azure-AD-OAuth.md)

## Logged in as First.User

I was able to login to `https://bitbucket.proxy.auth-demo.docker/` through the **Demo Azure OAuth SSO** button
(providing the Azure password for `first.user` when prompted by Microsoft).
