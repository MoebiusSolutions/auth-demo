# Manual Actions in LDAP CLI

## Getting Admin Password

We can see the current admin password with this helper script:

```
bash show-secrets.sh
```

## Connecting to LDAP

We can hit the LDAP server from two places:

* From the host machine (outside of docker), as `127.0.0.1:1389`
    * For example: `ldapsearch -x -b 'dc=example,dc=com' -H 'ldap://127.0.0.1:1389'`

* From inside any container, as `ldap:389`
    * For example: `docker compose exec ldap ldapsearch -x -b 'dc=example,dc=com' -H 'ldap://ldap:389'`

Anonymous authentication is partially enabled, so we can connect without credentials:

```
docker compose exec ldap \
    ldapsearch \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap:389'

```

... or with credentials (replacing `password` with the real password):

```
docker compose exec ldap \
    ldapsearch \
        -D 'cn=admin,dc=example,dc=com' -w 'password' \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap:389'
```

## Listing Contents (ldapsearch)

List all objects:

```
docker compose exec ldap \
    ldapsearch \
        -D 'cn=admin,dc=example,dc=com' -w 'password' \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap:389'
```

List all users:

```
docker compose exec ldap \
    ldapsearch \
        -D 'cn=admin,dc=example,dc=com' -w 'password' \
        -x -b 'dc=example,dc=com' -H 'ldap://ldap:389' \
        "objectclass=inetOrgPerson"
```

## Adding Users/Groups (ldapadd)

Given that we have the sample `.ldif` file [ldap-init.ldif.bashtemlpate](ldap/ldap-init.ldif.bashtemlpate)
mounted into the ldap container, we can manually load it into the directory server with this:

```
docker compose exec ldap \
    ldapadd \
        -D 'cn=admin,dc=example,dc=com' -w 'password' \
        -H 'ldap://ldap:389' -f /opt/ldap-init/ldap-init.ldif.bashtemlpate
```

... but you will likely have to manually modify the contents of that particular `.ldif`,
as that file is intented for auto-load on startup.
