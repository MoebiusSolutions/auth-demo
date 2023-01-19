# Atlassian/Keycloak/OpenLDAP/SSO Auth Demo (auth-demo)

## Repo Identity

At the time of this writing, this project was hosted at:

* [github.com/MoebiusSolutions/auth-demo](https://github.com/MoebiusSolutions/auth-demo)

## Overview

This repo is a work in progress, but here is a snapshot of what was implemented at the time of this writing:

![](https://www.moesol.com/plantuml/png/bOzFIyD04CNlyoc6dCoXv5vA82feQSLW4Iy5sSsEpPAuksmsrY1-TxDh_eXGggSPvltUpBoQNXmwZLOUIeT2MYgSr0g07KWvlCrogzyxP0qQtmpZUqDgUvtbVbuBPa1fGHWz4SVCc2R23q3yHarfFCd4grGZ_jpAIOysr1MrPjLUhNYwo-wsk1RvAk5fvF5gK6V-KZhU5XMvsR2RUJwga-7AwgFmKk4R-0G8IN2HJikN-41lP1l2a7QlBahdJ3o3mzDdkUdwMJ8ySug2uTvuUecFJOybDrQtfkanFupxQec9v6YbenZ2nZyv5bhLNGnZ-lzuO4hu8yGlMyZm1G00.png)

Here is the SAML SSO workflow:

![](https://www.moesol.com/plantuml/png/TP71Ri8m44Jl-OeLf_Q0UaS82UYbAbKZwB5IvTXRiafYk-jDKVlrjGCXf8YRevqPlPaeBOvXnUuGa445A8xFp2iMqkIL5V2btpmkSsKQiabJ6-K_MXff9YkIejKLohkT5ulTycK3ktp-K2mcNMn_7PkUyKVNJbM3vyaCfkfq7NdM4T2agqwFqUdLeqsWFMEMdTh0T34Gp61TawwWTljOfsX5d3qBvzDBuHODiHOG1pqfVCQzEkjbU4ywWvpTDnc4Dbqqeq4hfEgGzP8aJt0HmzbFukPQUW4p17VhYAim_W9hW0Uqy_8twcxngyKWqU8TAAqn1BWxa9J7pBUKUP-T3SdTRJiGxjcr7Xfi2kHGakz6K58wfbyb5FVh3DVL_Xjlx9mpXbZ-IAYTbVZn1m00.png)

## Getting Started

1. Create `.env` (and tweak settings if necessary):

   ```
   cp .env.template .env
   ```

2. Copy the output of the following command into your `/etc/hosts` file
   (allowing the host browser to resolve the docker hosts):

   ```
   bash show-hosts.sh
   ```

3. Start the cluster, per [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md):

   ```
   bash redeploy.sh
   ```

4. View auto-generated passwords, per [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md):

   ```
   bash show-secrets.sh
   ```

5. Save a copy of CA cert:

   ```
   sudo docker compose run -it --rm secrets cat /secrets/certs/ca-shared/root-ca.crt > root-ca.crt
   ```

   ... and then load the file into your browser as a Certificate Authority

5. Follow [Initialize Crowd](docs/Setup_Initialize-Crowd.md)

6. Follow [Initialize Bitbucket](docs/Setup_Initialize-Bitbucket.md)

7. Follow [Initialize Keycloak](docs/Setup_Initialize-Keycloak.md)

8. Setup SAML SSO via Keycloak

    * Follow [Download IDP Metadata XML from Keycloak](docs/Setup_Download-IDP-Metadata-XML-from-Keycloak.md)

    * Follow [Add SAML Authentication to Bitbucket](docs/Setup_Add-SAML-Authentication-to-Bitbucket.md)

    * Follow [Add SAML Client to Keycloak](docs/Setup_Add-SAML-Client-to-Keycloak.md)

    * At this point using the **Demo Keycloak SAML SSO** button on the Bitbucket login page
      should acceptin Peter Swanson's credentials and redirect back to Bitbucket
   
        * NOTE: "Logout" does not behave as expectd. See [Fixing SAML SSO Logout](docs/Fixing-SAML-SSO-Logout.md).

## Service Links

**NOTE**: All of the following hostnames come from `/etc/hosts` entries you should install from `show-hosts.sh`

Proxied (HTTPS) service URLs:

* OpenLDAP UI [https://ldap-ui.proxy.auth-demo.docker/](https://ldap-ui.proxy.auth-demo.docker/)
   * **TODO**: Fix this proxy connection. Either we have to load a proper cert into the backend container,
     or we have to enable an HTTP service port.
* Keycloak [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)
* Crowd: [https://crowd.proxy.auth-demo.docker/](https://crowd.proxy.auth-demo.docker/)
* Bitbucket: [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/)

Direct/internal service URLs:

* OpenLDAP UI [https://ldap-ui.auth-demo.docker:443/](https://ldap-ui.auth-demo.docker:443/)
* Keycloak [http://keycloak.auth-demo.docker:8080/](http://keycloak.auth-demo.docker:8080/)
* Crowd: [http://crowd.auth-demo.docker:8095/](http://crowd.auth-demo.docker:8095/)
* Bitbucket: [http://bitbucket.auth-demo.docker:7990/](http://bitbucket.auth-demo.docker:7990/)
* Bitbucket SSH: [http://bitbucket.auth-demo.docker:7999/](http://bitbucket.auth-demo.docker:7999/)

## Other Docs

* [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md)
* [Manual Actions in LDAP UI](docs/Manual-Actions-in-LDAP-UI.md)
* [Manual Actions in LDAP CLI](docs/Manual-Actions-in-LDAP-CLI.md)
* [Resolving "Found an Attribute element with duplicated Name" SAML Error in Bitbucket](docs/Resolving-Found-an-Attribute-element-with-duplicated-Name-SAML-Error-in-Bitbucket.md)
* [The OpenLDAP Admin User is Not Listed in LDAP Queries](docs/The-OpenLDAP-Admin-User-is-Not-Listed-in-LDAP-Queries.md)
* [Fixing SAML SSO Logout](docs/Fixing-SAML-SSO-Logout.md)
