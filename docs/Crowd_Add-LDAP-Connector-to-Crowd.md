# Crowd - Add LDAP Connector to Crowd

Open [http://crowd.proxy.auth-demo.docker/](http://crowd.proxy.auth-demo.docker/) and login as admin

Click **Directories**, then click **Add directory**, then select **Connector** and click **Next**

Enter the following into **Create Directory Connectory**, and click **Continue**:

* Details tab
    * Name: `Demo LDAP`
* Connector tab
    * Connector: `OpenLDAP (Read-Only Posix Schema)`
        * NOTE: Chosen to approximate a read-only upstream LDAP
    * URL: `ldap://ldap.auth-demo.docker:389/`
    * SSL: `None`
        * **TODO**: Enable SSL
    * Use node referrals: `[_]` (default setting)
    * Manage groups locally: `[✓]`
        * NOTE: Chosen to approximate a read-only upstream LDAP
    * Use the user memberhsip attribute: `[_]` (default setting)
    * Use paged results: `[_]` (default setting)
    * Use naive DN matching: `[✓]` (default setting)
    * Base DN: `dc=example,dc=com`
    * Username: `cn=ldap-bind,dc=example,dc=com`
    * Password: (see `authdemo-show-secrets.sh` output for `LDAP Bind`)

From the **View directory - OpenLDAP** page, **Details** tab, click **Synchronize now**