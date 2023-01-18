# Setup - Add SAML Client to Keycloak

Open Keycloak at [http://keycloak.auth-demo.docker:8080/](http://keycloak.auth-demo.docker:8080/),
then **Administration Console**, and then login as admin

Ensure that the `SSO-Realm` is active (top of left panel)

* To change: Hover over the left panel header until `SSO-Realm` is selectable

Click **Clients** in the left panel, then click the **Create** button

Enter the following on **Add Client**, then click **Save**:

* Client ID: (the **Audience URL (Entity ID)** from Bitbucket) `https://bitbucket.proxy.auth-demo.docker`
* Client Protocol: `saml`
* Client SAML Endpoint: (blank)

Enter the following on the **Settings** tab, then click **Save**:

* Settings tab:
    * Enabled: `ON`
    * Always Display in Console: `OFF`
    * Consent Required: `OFF`
    * Client Protocol: `saml`
    * Include AuthnStatement: `ON`
    * Include OneTimeUse Condition: `OFF`
    * Force Artifact Binding: `OFF`
    * Sign Documents: `ON`
    * Optimize REDIRECT signing key lookup: `OFF`
    * Sign Assertions: `ON` (non-default)
    * Signature Algorithm: `RSA_SHA256`
    * SAML Signature Key Name: `KEY_ID`
    * Canonicalization Method: `EXCLUSIVE`
    * Encrypt Assertions: `OFF`
    * Client Signature Required: `OFF` (non-default)
    * Force POST Binding: `ON`
    * Front Channel Logout: `ON`
    * Force Name ID Format: `ON` (non-default)
    * Name ID Format: `username`
    * Root URL: (blank)
    * Valid Redirect URIs: `https://bitbucket.proxy.auth-demo.docker/*`
    * Base URL: (blank)
    * Master SAML Processing URL: (the **Assertion Consumer Service URL** from Bitbucket) `https://bitbucket.proxy.auth-demo.docker/plugins/servlet/samlconsumer`

From the **Mappers** tab, click **Create** to define a new Mapper

Enter the following on **Create Protocol Mapper**, then click **Save**:

    * Protcol: `saml`
    * Name: `Role-to-Single-Attribute`
    * Mapper Type: `Role list`
    * Role attribute name: `Role`
    * Friendly name: (blank)
    * SAML Attribute NameFormat: `Basic`
    * Single Role Attribute: `ON`

NOTE: I have seen situations where Keycloak failed to (immediately?) apply the above Mapper config.
Restarting Keycloak did not immediatley resolve it.
Disabling/saving/enabling/saving the overall Client in Keycloak may have resolved it.

You can see the symptoms of the Mapper's omission here:
[Resolving "Found an Attribute element with duplicated Name" SAML Error in Bitbucket](Resolving-Found-an-Attribute-element-with-duplicated-Name-SAML-Error-in-Bitbucket.md)
