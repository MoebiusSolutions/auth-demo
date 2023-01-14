# Setup - Initialize Crowd

## Provision Crowd

Connect to [http://127.0.0.1:8095/](http://127.0.0.1:8095/)

Start the setup wizard

* You should be presented with a system ID and prompted for a license key

Use [my.atlassian.com](https://my.atlassian.com/) to create a Data Center (trial) license for Crowd

Enter the license key and click **Next**

Enter **Database configuration** options and click **Next**:

* Select the type of database you would like to use with Crowd: `Embedded`

Enter **Options** options and click **Next**:

* Deployment Title: `NISE Crowd`
* Session timeout: `30`
* Base URL: `http://127.0.0.1:8095/crowd`

Enter **Internal directory** and click **Next**:

* Name: `NISE Crowd`
* Password encryption: `ATLASSIAN-SECURITY`

Enter **Default administrator** options and click **Next**:

* ...

Enter **Integrated applications** options and click **Next**:

* OpenID server: `[✓]` (not actually sure if needed)

## Add LDAP Connector to Crowd

Open [Crowd](http://127.0.0.1:8095/) and login

Click **Directories**, then click **Add directory**, then select **Connector** and click **Next**

Enter the following into **Create Directory Connectory**, and click **Continue**:

* Details tab
    * Name: `OpenLDAP`
* Connector tab
    * Connector: `OpenLDAP (Read-Only Posix Schema)`
        * NOTE: Chosen to approximate a read-only upstream LDAP
    * URL: `ldap://ldap:389/`
    * SSL: `None`
        * **TODO**: Enable SSL
    * Use node referrals: `[_]` (default setting)
    * Manage groups locally: `[✓]`
        * NOTE: Chosen to approximate a read-only upstream LDAP
    * Use the user memberhsip attribute: `[_]` (default setting)
    * Use paged results: `[_]` (default setting)
    * Use naive DN matching: `[✓]` (default setting)
    * Base DN: `dc=example,dc=com`
    * Username: `cn=admin,dc=example,dc=com`
        * **TODO**: Provision a crowd-specific bind user
    * Password: (see `show-secrets.sh` output for LDAP Admin)

From the **View directory - OpenLDAP** page, **Details** tab, click **Synchronize now**

## Add Bitbucket Application to Crowd

Open [Crowd](http://127.0.0.1:8095/) and login

Click **Applications**, then click **Add application**

Enter the following into **Add application**, and click **Next**:

* Application type: `Bitbucket Server`
* Name: `Bitbucket`
* Password: (generate a random password)

Enter the following into **Add appliation - bitbucket**, and click **Next**:

* URL: `http://bitbucket:7990/`
* Remote IP address: (auto populated via **Resolve IP Address**
    * NOTE: This will change on system restarts (containers are recreated with random IPs)

Enter the following into **Add application - bitbucket**, and click **Next**:

* NISE Crowd: `[✓]`
* OpenLDAP: `[✓]`
    * **NOTE**: The first time around I left **OpenLDAP** disabled here.
      I had to manually add it to the **Directories & groups** tab of the `Bitbucket` Application.
      Then I had to click **⋯**, **Configure authentication**, and then enable **Allow all users from this directory to authenticate.**.
      I'm not sure how much of this I should add to these instructios for a fresh configuration.

Enter the following into **Add application - bitbucket**, and click **Next**:

* Allow all users to authenticate: `[✓]`

Click **Add application** to finish the process
