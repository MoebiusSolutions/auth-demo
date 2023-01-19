# Atlassian/Keycloak/OpenLDAP/SSO Auth Demo (auth-demo)

## Repo Identity

At the time of this writing, this project was hosted at:

* [github.com/MoebiusSolutions/auth-demo](https://github.com/MoebiusSolutions/auth-demo)

## Overview

This repo is a work in progress, but here is a snapshot of what was implemented at the time of this writing:

![](https://www.moesol.com/plantuml/png/bOzFIyGm4CNlyoc6FMqFozxti50L51HS1F4YIDgCsz2Q3CdKjOZVtIQsKGHPzvJ9Ux_vypfw5XI7tkmRGMqyrMAS1L1xie9NvSwxjm5LG8x59DyosPkBSXVrJYi6wpJXue4gB9d30jy1yGlbXYEfz8knC_xKc-nVqr1tJhNHQwSwcsT6ghvkIQ9RpPzidtjtqD6gOm4V0Eb8N6tpg0tUqIlvG9Y2FDfb8yB5DpZTSvJBsu-IwPY_A9ZspQitU1z6R7tfNSzXnA9OZAydfTS7RuGAI1F_rR5ojXiAcDEVqWCvuOyGlzfIXay0.png)

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

8. Follow [Download IDP Metadata XML from Keycloak](docs/Setup_Download-IDP-Metadata-XML-from-Keycloak.md)

9. Follow [Add SAML Authentication to Bitbucket](docs/Setup_Add-SAML-Authentication-to-Bitbucket.md)

10. Follow [Add SAML Client to Keycloak](docs/Setup_Add-SAML-Client-to-Keycloak.md)

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
