# Setup - Initialize Crowd

## Provision Crowd

Open [http://crowd.proxy.auth-demo.docker/](http://crowd.proxy.auth-demo.docker/)

Click **Set up Crowd** to start the setup wizard

* You should be presented with a system ID and prompted for a license key

Use [my.atlassian.com](https://my.atlassian.com/) to create a Data Center (trial) license for Crowd

Enter the license key and click **Continue**

On **Crowd installation**, select **New Installation**  and click **Continue**:

On **Database configuration**, select **Embedded** and click **Continue**:

Enter the following into **Options** and click **Continue**:

* Deployment Title: `Demo Crowd`
* Session timeout: `30`
* Base URL: `https://crowd.proxy.auth-demo.docker/crowd`

Enter the following into **Internal directory** and click **Continue**:

* Name: `Demo Crowd`
* Password encryption: `ATLASSIAN-SECURITY`

Enter the following into **Default administrator** and click **Continue**:

* Email address: (your email address)
* Username: (see output of `show-secrets.sh` for `Crowd Admin`)
* Password: (see output of `show-secrets.sh` for `Crowd Admin`)
* First name: `Crowd`
* Last name: `Admin`

Enter **Integrated applications** options and click **Next**:

* OpenID server: `[_]` (not yet needed)

## Add LDAP Connector to Crowd

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
    * Password: (see `show-secrets.sh` output for `LDAP Bind`)

From the **View directory - OpenLDAP** page, **Details** tab, click **Synchronize now**

## Add Bitbucket Application to Crowd

Open [http://crowd.proxy.auth-demo.docker/](http://crowd.proxy.auth-demo.docker/) and login as admin

Click **Applications**, then click **Add application**

Enter the following into **Add application** and click **Next**:

* Application type: `Bitbucket Server`
* Name: (see `Crowd/Bitbucket App Connector` name from `show-secrets.sh`)
* Password: (see `Crowd/Bitbucket App Connector` password from `show-secrets.sh`)

Enter the following into **Add appliation - bitbucket** and click **Next**:

* URL: `http://bitbucket.auth-demo.docker:7990/`
    * Click **Resovle IP Adress**
* Remote IP address: (auto populated)

**TODO**: Should this URL be changed to the proxy URL?
It probably requires setting up root CA trust in Tomcat.

Enter the following into **Add application - bitbucket** and click **Next**:

* Demo Crowd: `[✓]`
* Demo LDAP: `[✓]`

Enter the following into **Add application - bitbucket**, and click **Next**:

* Directory - Demo Crowd
    * Allow all users to authenticate: `[✓]`
* Directory - Demo LDAP
    * Allow all users to authenticate: `[✓]`

Click **Add application** to finish the process
