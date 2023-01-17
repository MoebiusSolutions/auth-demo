# Resolving "Found an Attribute element with duplicated Name" SAML Error in Bitbucket

## The Error

After setting up a SAML Authentication Method in Bitbucket and a
`https://bitbucket.proxy.auth-demo.docker` SAML Client in KeyCloak,
Bitbucket SSO logins were kicking out this error in the Bitbucket log:

```
...  com.atlassian.plugins.authentication.sso.web.saml.provider.InvalidSamlResponse: com.onelogin.saml2.exception.ValidationError: Found an Attribute element with duplicated Name ...
```

## The Cause

Using the Network tab of Developer Tools, I was able to inspect this request:

```
POST https://bitbucket.proxy.auth-demo.docker/plugins/servlet/samlconsumer HTTP/1.1
```

Then I saved the value of the `SAMLResponse` field in the form payload to a file `saml-response.b64`.

Then I was able to view the SAML response with this:

```
cat saml-response.b64 | base64 -d | xmllint --format -
```

I noticed that it had these entries:

```
<samlp:Response xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
...
        <saml:AttributeStatement>
            <saml:Attribute Name="Role"
                            NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
                            >
                <saml:AttributeValue xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                     xsi:type="xs:string"
                                     >create-realm</saml:AttributeValue>
            </saml:Attribute>
            <saml:Attribute Name="Role"
                            NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
                            >
                <saml:AttributeValue xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                     xsi:type="xs:string"
                                     >view-authorization</saml:AttributeValue>
            </saml:Attribute>
...
        </saml:AttributeStatement>
...
</samlp:Response>
```

It seemed like Bitbucket wanted all `AttributeValue` of `Attribute`s with the same
`Name` to be nested under one `Attribute`.

## The Resolution

Within the `https://bitbucket.proxy.auth-demo.docker` SAML Client I'd defined to Keycloak,
I defined a new Mapper:

* Opened the **Mappers** tab and clicked **Create**
    * Protcol: `saml`
    * Name: `Role-Attribute-to-Single-Attribute`
    * Mapper Type: `Role list`
    * Role attribute name: `Role`
    * Friendly name: (blank)
    * SAML Attribute NameFormat: `Basic`
    * Single Role Attribute: `ON`

Now when I inspected a Bitbucket SAML SSO login, I saw this payload:

```
<samlp:Response xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
...
        <saml:AttributeStatement>
            <saml:Attribute Name="Role"
                            NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
                            >
                <saml:AttributeValue xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                     xsi:type="xs:string"
                                     >create-realm</saml:AttributeValue>
                <saml:AttributeValue xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                     xsi:type="xs:string"
                                     >view-authorization</saml:AttributeValue>
...
            </saml:Attribute>
        </saml:AttributeStatement>
...
</samlp:Response>
```
