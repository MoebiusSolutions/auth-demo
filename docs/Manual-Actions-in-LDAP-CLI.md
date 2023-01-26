# Manual Actions in LDAP CLI

## Getting Admin Password

We can see the current admin password with this helper script:

```
bash authdemo-show-secrets.sh
```

## Connecting to LDAP

We can hit the LDAP server from two places:

* From the host machine (outside of docker), as `ldap.auth-demo.docker:389`
    * For example: `ldapsearch -x -b 'dc=example,dc=com' -H 'ldap://ldap.auth-demo.docker:389'`

* From inside any container, as `ldap.auth-demo.docker:389`
    * For example: `docker compose exec ldap ldapsearch -x -b 'dc=example,dc=com' -H 'ldap://ldap.auth-demo.docker:389'`

Anonymous authentication is partially enabled (at the time of this writing), so we can connect without credentials:

```
docker compose exec ldap \
    ldapsearch \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap.auth-demo.docker:389'

```

... or with credentials (LDAP Admin password coming from `authdemo-show-secrets.sh`):

```
docker compose exec ldap \
    ldapsearch \
        -D 'cn=admin,dc=example,dc=com' -W \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap.auth-demo.docker:389'
```

## Listing Contents (ldapsearch)

List all objects:

```
docker compose exec ldap \
    ldapsearch \
        -D 'cn=admin,dc=example,dc=com' -W \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap.auth-demo.docker:389'
```

List all users:

```
docker compose exec ldap \
    ldapsearch \
        -D 'cn=admin,dc=example,dc=com' -W \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap.auth-demo.docker:389' \
        "objectclass=inetOrgPerson"
```

NOTE: [The OpenLDAP Admin User is Not Listed in LDAP Queries](The-OpenLDAP-Admin-User-is-Not-Listed-in-LDAP-Queries.md)

## Adding Users/Groups (ldapadd)

Given that we have the sample `.ldif` file [ldap-init.ldif.bashtemlpate](ldap/ldap-init.ldif.bashtemlpate)
mounted into the ldap container, we can manually load it into the directory server with this:

```
docker compose exec ldap \
    ldapadd \
        -D 'cn=admin,dc=example,dc=com' -W \
        -H 'ldap://ldap.auth-demo.docker:389' -f /opt/ldap-init/ldap-init.ldif.bashtemlpate
```

... but you will likely have to manually modify the contents of that particular `.ldif`,
as that file is intented for auto-load on startup.

## Testing User Logins

We can test the password of a regular user (e.g. Peter Swanson) with this:

```
docker compose exec ldap \
    ldapwhoami -x -vvv \
        -D 'cn=Peter Swanson,dc=example,dc=com' -W \
        -H 'ldap://ldap:389'
```
