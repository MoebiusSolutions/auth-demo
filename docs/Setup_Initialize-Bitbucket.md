# Setup - Initialize Bitbucket

## Provision Crowd

Open Bitbucket at [http://127.0.0.1:7990/](http://127.0.0.1:7990/)

Enter **Welcome** options and click **Next**:

* Database: `Internal`

Use [my.atlassian.com](https://my.atlassian.com/) to create a Data Center (trial) license for Bitbucket

Enter the license key and click **Next**

Enter **Administrator account setup** options:

* Username: `admin`
* Full name: `Administrator`
* Email address: (working email address)
* Password: (a random password)

... and click **Go to Bitbucket**

## Add Crowd Directory to Bitbucket

Open Bitbucket at [http://127.0.0.1:7990/](http://127.0.0.1:7990/) and login as the admin

Open **Administration**, then click **User Directories** on left panel, then click **Add Directory**, select **Atlassian Crowd** and click **Next**

Enter the following options on **Confiure Atlassian Crowd Server** and click **Save and Test**:

* Name: `Crowd Server`
* Server URL: `http://crowd:8095/crowd/`
* Application Name: `Bitbucket` (must match what was setup as an App inside of Crowd)

Click **User Directories** in the left panel, then click **Synchronize** next to the newly created `Crowd Server`

Refresh the page to update the sync status message

## Grant LDAP Group Access to Bitbucket

Open Bitbucket at [http://127.0.0.1:7990/](http://127.0.0.1:7990/) and login as the admin

Click **Global permissions** on the left panel

Under **Group Access**, enter `Developers`, then select `Bitbucket User`, then click **Add**

## Verify Ability to Login as LDAP Developer

Open Bitbucket at [http://127.0.0.1:7990/](http://127.0.0.1:7990/) and logout (if already logged in)

Login as:

* Username: `pswanson`
* Password: (see output of `show-secrets.sh` for Peter Swanson)
