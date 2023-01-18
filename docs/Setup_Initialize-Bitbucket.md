# Setup - Initialize Bitbucket

## Provision Bitbucket

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/)

Enter the following on **Welcome** and click **Next**:

* Database: `Internal`

Enter the following on **Licensing and settings**:

* Application title: `Demo Bitbucket`
* Base URL: `https://bitbucket.proxy.auth-demo.docker/`

Copy the **Server ID** from **License and settings**, and use it on 
[my.atlassian.com](https://my.atlassian.com/) to create a Data Center (trial) license for Bitbucket

Select **I have a Bitbucket license key**, enter the new license key, and click **Next**

Enter **Administrator account setup** options:

* Username: (see output of `show-secrets.sh` for `Bitbucket Admin`)
* Full name: `Bitbucket Admin`
* Email address: (your email address)
* Password: (see output of `show-secrets.sh` for `Bitbucket Admin`)

... and click **Go to Bitbucket**

## Add Crowd Directory to Bitbucket

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/) and login as the admin

Open **Administration** (gear icon)

Click **User Directories** on left panel, then click **Add Directory**, select **Atlassian Crowd** and click **Next**

Enter the following options on **Confiure Atlassian Crowd Server** and click **Test Settings**:

* Name: `Demo Crowd`
* Server URL: `http://crowd.auth-demo.docker:8095/crowd/`
* Application Name: (see output of `show-secrets.sh` for `Crowd/Bitbucket App Connector`)
* Application Password: (see output of `show-secrets.sh` for `Crowd/Bitbucket App Connector`)

Click **Save and Test** to save the settings

Click **Synchronize** next to the newly created `Demo Server` entry

Click **Users** in the left panel, and confirm that the user `Peter Swanson` was loaded from LDAP

## Grant LDAP Group Access to Bitbucket

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/) and login as the admin

Open **Administration** (gear icon)

Click **Global permissions** on the left panel

Under **Group Access**, enter `Developers`, then select `Bitbucket User`, then click **Add**

## Verify Ability to Login as LDAP Developer

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/)
and logout (if already logged in)

Login as:

* Username: `pswanson`
* Password: (see output of `show-secrets.sh` for Peter Swanson)
