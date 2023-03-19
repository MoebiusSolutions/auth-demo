# Demonstrating Proxying Single Hostname via Context Path

## Overview

This describes tweaks to the configuration to support proxying all Atlassian products through a single hostname.

This is useful in environments where the proxy server is only allowed one hostname.

I saved this work on a `demonstrating-proxying-single-hostname-via-context-path` branch.


# Generate Proxy Cert

First off, since all request go through one hostname, we need that single hostname.
Let us go with `proxy.auth-demo.docker`, which has not had its own certificate before this.

I updated `secrets/gen-certs.sh`--adding a `proxy.${ENV_DOMAIN}` entry:

```
# Create certs
create_root_cert "${TARGET_DIR}/ca-private"
...
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "proxy.${ENV_DOMAIN}"
```

# Set Context Path in Crowd

It turns out Crowd is already running with at `/crowd` context path,
so there is no need to add one.


# Set Context Path in Bitbucket

I created `bitbucket/bitbucket.properties` with the following contents:

    server.context-path=/bitbucket

Then I updated `docker-compose.yml`--adding the following volume:

```
  bitbucket:
...
    volumes:
...
      - "./bitbucket/bitbucket.properties:/var/atlassian/application-data/bitbucket/shared/bitbucket.properties:ro"
```

... and updating the proxy variables:


```
  jira:
...
    environment:
#      SERVER_PROXY_NAME: "bitbucket.proxy.${ENV_DOMAIN}"
      SERVER_PROXY_NAME: "proxy.${ENV_DOMAIN}"
      SERVER_PROXY_PORT: "443"
      SERVER_SCHEME: "https"
      SERVER_SECURE: "true"
```

# Set Context Path in Jira

I created `jira/server.xml` by dumping out the file from a live instance:

```
sudo docker compose exec jira cat /opt/atlassian/jira/conf/server.xml > jira/server.xml
```

The file had thes contents:

```
<Server port="8005"
        shutdown="SHUTDOWN">
...
  <Service name="Catalina">
...
    <Engine name="Catalina"
            defaultHost="localhost">
...
      <Host name="localhost"
            appBase="webapps"
            unpackWARs="true"
            autoDeploy="true">
...
        <Context path=""
                 docBase="${catalina.home}/atlassian-jira"
                 reloadable="false"
                 useHttpOnly="true">
```

... which I updated by setting `<Context path=""` to `<Context path="/jira"`.

Then I updated `docker-compose.yml`--adding the following volume:

```
  jira:
...
    volumes:
...
      - "./jira/server.xml:/opt/atlassian/jira/conf/server.xml:ro
```

... and updating the proxy variables:


```
  jira:
...
    environment:
#      ATL_PROXY_NAME: "jira.proxy.${ENV_DOMAIN}"
      ATL_PROXY_NAME: "proxy.${ENV_DOMAIN}"
      ATL_PROXY_PORT: "443"
      ATL_TOMCAT_SCHEME: "https"
      ATL_TOMCAT_SECURE: "true"
```

# Configured HAProxy

I updated `proxy/haproxy.cfg` to filter on path instead of hostname (and simply disabled other services):

```
#    use_backend ldap_ui_be if { req.hdr(host) -i ldap-ui.proxy.${ENV_DOMAIN} }
#    use_backend keycloak_be if { req.hdr(host) -i keycloak.proxy.${ENV_DOMAIN} }
    use_backend crowd_be if { path /crowd } || { path_beg /crowd/ } 
    use_backend bitbucket_be if { path /bitbucket } || { path_beg /bitbucket/ } 
    use_backend jira_be if { path /jira } || { path_beg /jira/ }
#    use_backend artifactory_be if { req.hdr(host) -i artifactory.proxy.${ENV_DOMAIN} }
```

