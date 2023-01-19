# Fixing SAML SSO Logout

There are two levels of logout that could be supported:

1. Getting the IDP to log you out when you click "logout" in an app (an SP)
2. Getting the IDP to log out ALL apps (SPs) when any one app tells the IDP to logout

Right now I don't even have the first one working.
When you click the logout button in Bitbucket, then click the `Demo SAML-SSO` button,
it immediately logs you back in (using the active Keycloak session).

Here is some more infomation about standard operating procedures for logout:

* [How to Log Out From a SAML Application](https://uit.stanford.edu/service/saml/logout)
* [The Challenge of Building SAML Single Logout](https://www.identityserver.com/articles/the-challenge-of-building-saml-single-logout)

How we might implement logout in Bitbucket & Keycloak:

* We may need to populate the **Logout Service XXX** fields under **Fine Grain SAML Endpoint Configuration** of the **Client** we defined in Keycloak
    * I believe this will only help with the IDP logging out the other SPs, not the SP logging out the IDP
* There is also a **Front Channel Logout** field in the **Client** we defined in Keycloak, but this has always been enabled in my testing
* There is a **SAML SSO behaviour: Remember user logins** option in the **Authentication method** we defined in Bitbucket that might have some bearing

[this](https://community.atlassian.com/t5/Marketplace-Apps-Integrations/How-to-Enable-Single-Logout-SLO-in-Atlassian-Data-Center/ba-p/1405724)
post states that:

> ... Unfortunately, Single Logout is not included in the Data Center SSO features ...

... but that needs a little verification. The native plugin appears to have changed names since then.

It looks like the native SSO plugin (`SSO for Atlassian Data Center plugin`) has at least two major competitors,
both of which likely handle logouts more completely:

* [MiniOrange](https://miniorange.com/atlassian/setup-saml-single-sign-on-sso-for-bitbucket?version=2.0.0)
* [re:solution](https://www.resolution.de/sso-saml-overview/)
