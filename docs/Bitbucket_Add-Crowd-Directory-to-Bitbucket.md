# Bitbucket - Add Crowd Directory to Bitbucket

Open Bitbucket at [https://bitbucket.proxy.auth-demo.docker/](https://bitbucket.proxy.auth-demo.docker/) and login as the admin

Open **Administration** (gear icon)

Click **User Directories** on left panel, then click **Add Directory**, select **Atlassian Crowd** and click **Next**

Enter the following options on **Confiure Atlassian Crowd Server** and click **Test Settings**:

* Name: `Demo Crowd`
* Server URL: `http://crowd.auth-demo.docker:8095/crowd/`
* Application Name: (see output of `authdemo-show-secrets.sh` for `Crowd/Bitbucket App Connector`)
* Application Password: (see output of `authdemo-show-secrets.sh` for `Crowd/Bitbucket App Connector`)

Click **Save and Test** to save the settings

Click **Synchronize** next to the newly created `Demo Server` entry

Click **Users** in the left panel, and confirm that the user `Peter Swanson` was loaded from LDAP
