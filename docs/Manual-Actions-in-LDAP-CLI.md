# Manual Actions in LDAP CLI

## Listing Contents (ldapsearch)

From the host, we can list all objects in LDAP unauthenticated:

```
ldapsearch -x -b 'dc=example,dc=com' -h '127.0.0.1' -p 1389
```

... or authenticated:

```
ldapsearch \
    -D 'cn=admin,dc=example,dc=com' -w 'password' \
    -x -b 'dc=example,dc=com' -h '127.0.0.1' -p 1389
```

We can search for users by filtering on `objectclass=inetOrgPerson`

ldapsearch \
    -w 'password' -b 'dc=example,dc=com' \
    -x -D 'cn=admin,dc=example,dc=com' -h '127.0.0.1' -p 1389 \
    "objectclass=inetOrgPerson"
