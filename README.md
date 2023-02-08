# Atlassian/Keycloak/OpenLDAP/SSO Auth Demo (auth-demo)

## Repo Identity

At the time of this writing, this project was hosted at:
[github.com/MoebiusSolutions/auth-demo](https://github.com/MoebiusSolutions/auth-demo)

## Overview

This repo is used to demonstrate a variety of SSO configs.
It contains:

* A docker-compose environment that instantiates many DevOps services
* A reverse proxy with PKI certs for all services
* Many example setup procedures

## Start Here

[Getting Started](docs/Getting-Started.md)

## Documentation

Demonstration Procedures

* [Demonstrate LDAP Connection Between Keycloak and OpenLDAP](docs/Demonstrate-LDAP-Connection-Between-Keycloak-and-OpenLDAP.md)

* [Demonstrate Bitbucket Authentication through Crowd/LDAP to Keycloak/OpenLDAP](docs/Demonstrate-Bitbucket-Authentication-through-Crowd-LDAP-to-Keycloak-OpenLDAP.md)

   * [![](https://www.moesol.com/plantuml/png/bOzFIyD04CNlyoc6dCoXf5vB2KG55Ii6YtWfo2OxDalItMLtOnh4xsusvey8KZtDCE_tPkRPd5M41tR4y-KI6y5T0L3HgqEdq8XzuP0BGxaJIWAmFKc7DqbgrB55Pb7xPXW_Q9ARgoJryuep3L9nmk2PCaoqjW6-0-8NgWljISOFGexuIoqcFRYZDgyKAtTodSNRv7w3jpnTHraSUBmSr9c_42whyvBSRDZEV3Qga-7Ig8PxAVSDV03qIN0HJyjN-4XlP2nXdtOdpmhdT3Y3mzCdkUdwIR9_vZSAXdlZwHK-sGwBhesgjUqmFmoxQeZng372KGZznZyv5afMRGXZ-lzuO4huBSGFMv_X4m00)](https://www.moesol.com/plantuml/png/bOzFIyD04CNlyoc6dCoXv5vA82feQSLW4Iy5sSsEpPAuksmsrY1-TxDh_eXGggSPvltUpBoQNXmwZLOUIeT2MYgSr0g07KWvlCrogzyxP0qQtmpZUqDgUvtbVbuBPa1fGHWz4SVCc2R23q3yHarfFCd4grGZ_jpAIOysr1MrPjLUhNYwo-wsk1RvAk5fvF5gK6V-KZhU5XMvsR2RUJwga-7AwgFmKk4R-0G8IN2HJikN-41lP1l2a7QlBahdJ3o3mzDdkUdwMJ8ySug2uTvuUecFJOybDrQtfkanFupxQec9v6YbenZ2nZyv5bhLNGnZ-lzuO4hu8yGlMyZm1G00)
   
   * [![](https://www.moesol.com/plantuml/png/TP71JiCm44Jl_eeL9pXKb6jLLMhB1L54r794GewzRLP9R6DlAF3rs6dJD5IzETgPqPj9KB92gEKtF8p7i2VDXH1IiVMmy7OVq8CCa1-UmadFfCX9m-0AjtgSPrBNP9Acqj9zD3JGt2o8yqQLoEzcciysyvSLRBBfVJwxQMExwz3qZ3-gihBiFK-wDvN7wy2pZ80wNLLw34wl3aq2xHY5EBQ1qQmdcC2o8bL2PNUnJjumMtCIJaVdmZLgyeg1BNIai8rxjTRpy8vq0fctNwGHcdHH7ZKQ9ba5qKcIFC5536ksvEjBwHbC7zokmxR4-0kC1j-ZdPQ_KdUDdmq6ZXPdGIg58S3jdhWuPBwbp3jnCYHtksrFkFEsSL1ZdQCF1Rbs1Cc5zVGhcU9-hU6osd_ZbPqpZo6MFn0gQpX-_040)](https://www.moesol.com/plantuml/png/TP71Ri8m44Jl-OeLf_Q0UaS82UYbAbKZwB5IvTXRiafYk-jDKVlrjGCXf8YRevqPlPaeBOvXnUuGa445A8xFp2iMqkIL5V2btpmkSsKQiabJ6-K_MXff9YkIejKLohkT5ulTycK3ktp-K2mcNMn_7PkUyKVNJbM3vyaCfkfq7NdM4T2agqwFqUdLeqsWFMEMdTh0T34Gp61TawwWTljOfsX5d3qBvzDBuHODiHOG1pqfVCQzEkjbU4ywWvpTDnc4Dbqqeq4hfEgGzP8aJt0HmzbFukPQUW4p17VhYAim_W9hW0Uqy_8twcxngyKWqU8TAAqn1BWxa9J7pBUKUP-T3SdTRJiGxjcr7Xfi2kHGakz6K58wfbyb5FVh3DVL_Xjlx9mpXbZ-IAYTbVZn1m00)

* [Demonstrating OAuth from Bitbucket to Azure Active Directory](docs/Demonstrating-OAuth-from-Bitbucket-to-Azure-Active-Directory.md)


Minor Task Procedures (used by the above procedures)

* Azure
    * [Setup a Account and Tenant in Azure](docs/Azure_Setup-a-Account-and-Tenant-in-Azure.md)
    * [Defined Bitbucket OAuth Client Secret in Azure AD](docs/Azure_Defined-Bitbucket-OAuth-Client-Secret-in-Azure-AD.md)
    * [Exposed Azure AD to Bitbucket through OAuth](docs/Azure_Exposed-Azure-AD-to-Bitbucket-through-OAuth.md)
    * [Added OAuth Redirect URL to Azure AD for Bitbucket](docs/Azure_Added-OAuth-Redirect-URL-to-Azure-AD-for-Bitbucket.md)
    * [Added OAuth Token Claims to Azure AD for Bitbucket](docs/Azure_Added-OAuth-Token-Claims-to-Azure-AD-for-Bitbucket.md)
    * [Defined User and Group in Azure AD for Bitbucket OAuth](Azure_Defined-User-and-Group-in-Azure-AD-for-Bitbucket-OAuth.md)
* Keycloak
    * [Define an "SSO" Realm in Keycloak](docs/Keycloak_Define-an-SSO-Realm-in-Keycloak.md)
    * [Add LDAP Connecton to Keycloak](docs/Keycloak_Add-LDAP-Connecton-to-Keycloak.md)
* Crowd
    * [Initialize Crowd](docs/Crowd_Initialize-Crowd.md)
    * [Add LDAP Connector to Crowd](docs/Crowd_Add-LDAP-Connector-to-Crowd.md)
    * [Add Bitbucket Application to Crowd](docs/Crowd_Add-Bitbucket-Application-to-Crowd.md)
* Bitbucket
    * [Initialize Bitbucket](docs/Bitbucket_Initialize-Bitbucket.md)
    * [Add Crowd Directory to Bitbucket](docs/Bitbucket_Add-Crowd-Directory-to-Bitbucket.md)
    * [Grant LDAP Group Access to Bitbucket](docs/Bitbucket_Grant-LDAP-Group-Access-to-Bitbucket.md)
    * [Added Azure AD OAuth to Bitbucket](docs/Bitbucket_Added-Azure-AD-OAuth-to-Bitbucket.md)
    * [Defined User in Bitbucket for Azure AD OAuth](docs/Bitbucket_Defined-User-in-Bitbucket-for-Azure-AD-OAuth.md)

Other Docs

* [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md)
* [Manual Actions in LDAP UI](docs/Manual-Actions-in-LDAP-UI.md)
* [Manual Actions in LDAP CLI](docs/Manual-Actions-in-LDAP-CLI.md)
* [Resolving "Found an Attribute element with duplicated Name" SAML Error in Bitbucket](docs/Resolving-Found-an-Attribute-element-with-duplicated-Name-SAML-Error-in-Bitbucket.md)
* [The OpenLDAP Admin User is Not Listed in LDAP Queries](docs/The-OpenLDAP-Admin-User-is-Not-Listed.md)
* [Fixing SAML SSO Logout](docs/Fixing-SAML-SSO-Logout.md)

## Service Links

**NOTE**: All of the following hostnames come from `authdemo-show-hosts.sh`,
which should been installed to your `/etc/hosts`.

Proxied (HTTPS) service URLs:

* OpenLDAP UI [https://ldap-ui.proxy.auth-demo.docker/](https://ldap-ui.proxy.auth-demo.docker/)
   * **TODO**: Fix this proxy connection. Either we have to load a proper cert into the backend container,
     or we have to enable an HTTP service port.
* Keycloak [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)
* Crowd: [https://crowd.proxy.auth-demo.docker/](https://crowd.proxy.auth-demo.docker/)
* Bitbucket: [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/)
* Jira: [https://jira.proxy.auth-demo.docker/](https://jira.proxy.auth-demo.docker/)
* Artifactory: [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)

Direct/internal service URLs:

* OpenLDAP UI [https://ldap-ui.auth-demo.docker:443/](https://ldap-ui.auth-demo.docker:443/)
* Keycloak [http://keycloak.auth-demo.docker:8080/](http://keycloak.auth-demo.docker:8080/)
* Crowd: [http://crowd.auth-demo.docker:8095/](http://crowd.auth-demo.docker:8095/)
* Bitbucket: [http://bitbucket.auth-demo.docker:7990/](http://bitbucket.auth-demo.docker:7990/)
* Bitbucket SSH: [http://bitbucket.auth-demo.docker:7999/](http://bitbucket.auth-demo.docker:7999/)
* Jira: [https://jira.auth-demo.docker:8080/](https://jira.auth-demo.docker:8080/)
* Artifactory: [https://artifactory.auth-demo.docker:8082/](https://artifactory.auth-demo.docker:8082/)

