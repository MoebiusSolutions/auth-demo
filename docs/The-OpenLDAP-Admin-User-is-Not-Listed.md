# The OpenLDAP Admin User is Not Listed in LDAP Queries

It looks as if the OpenLDAP Admin user is defined outside of the LDAP database.

[Here](https://lists.openldap.org/hyperkitty/list/openldap-technical@openldap.org/thread/T5RU5RUW4KU4MM33TA6BXP77446SG7Q4/)
is a thread discussing the matter,
and section `5.2.5.4. olcRootDN: <DN>` of [Configuring slapd](https://www.openldap.org/doc/admin24/slapdconf2.html)
also seems relevant.

What I find especially confusing is that OpenLDAP puts the admin user in the domain of the user directory
(e.g. `cn=admin,dc=example,dc=com`), so you expect it to come back in queries to the domain.
