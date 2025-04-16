# Artifactory - "SAML Service Provider" Confusion

Somewhere between Artifactory 7.49.6 and 7.104.15, the meaning of the
**SAML Service Provider** setting in Artifactory's SAML settings page
was changed. I would argue "broken".

* Seaching "saml" in the
  [release notes](https://jfrog.com/help/r/jfrog-release-information/important-self-hosted-changes)
  reveals that versions 7.98.7 and 7.104.5 included SAML refactor work.

Even though the **SAML Service Provider** field has the help text
"The Artifactory name in the SAML federation",
instead it seems to be something akin to "SAML server ID".
The real SAML Service Prider name now seems to come directly from
the global **Custom Base URL** of Artifactory
(which the release notes note is now required for for SAML functionality).

If we dump out the SAMLRequest and SAMLResponse, we can see these values...

In Artfactory 7.49.6, we would get this SAMLRequest
(where `{{ SAML Service Provider }}` is substituted with the setting):

    <saml2p:AuthnRequest
    ...
        ProviderName="{{ SAML Service Provider }}">

        <saml2:Issuer
            xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion">{{ SAML Service Provider }}</saml2:Issuer>
    ...
    </saml2p:AuthnRequest>

In Artifactory 7.104.15, we get this SAMLRequest
(where `{{ Custom Base URL }}` is substituted with the setting):

    <saml2p:AuthnRequest ...>

        <saml2:Issuer
            xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion">{{ Custom Base URL }}</saml2:Issuer>
    </saml2p:AuthnRequest>

A few things changed:

* The **SAML Service Provider Name** setting in Artifactory has no impact on the SAMLRequest anymore.
* The SAMLRequest no longer contains a **ProviderName** field.
* From the perspective of the SAML IDP, we can no longer use a an arbitrary service provider name.
  It's locked to the Artifactory hostname.

Now "what should **SAML Service Provider Name** be set to in Artifactory?" you may you ask.
It looks like it needs to match the issuer of the SAMLResponse in order for things to work.

Let's look at the SAMLResponse that comes back from Keycloak
(which is running with an example hostname `keycloak.proxy.auth-demo.docker`):

    <samlp:Response ...>
      <saml:Issuer>https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm</saml:Issuer>
      <dsig:Signature ...>
    ...
      </dsig:Signature>
    ...
      <saml:Assertion ...>
        <saml:Issuer>https://keycloak.proxy.auth-demo.docker/auth/realms/SSO-Realm</saml:Issuer>
        <saml:Subject>
    ...
        </saml:Subject>
        <saml:Conditions NotBefore="2025-04-15T21:48:43.268Z" NotOnOrAfter="2025-04-15T21:49:43.268Z">
          <saml:AudienceRestriction>
            <saml:Audience>https://artifactory.proxy.auth-demo.docker</saml:Audience>
          </saml:AudienceRestriction>
        </saml:Conditions>
    ...
      </saml:Assertion>
    </samlp:Response>

It appears that Artifactory now requires the so-called **SAML Service Provider Name** to
match the `Issuer` field in the response or else it will reject the SAMLResponse.

Note that all of this lines up the Keycloak example in the current
[JFrog SAML Guide](https://jfrog.com/help/r/jfrog-platform-administration-documentation/saml-sso-configuration-with-keycloak),
but that is inspite of the fact that there are numerous typos the guide,
and the **SAML Service Provider Name** field being completely mislaballed (in my opinion).
