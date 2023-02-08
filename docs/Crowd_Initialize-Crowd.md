# Crowd - Initialize Crowd

Open [http://crowd.proxy.auth-demo.docker/](http://crowd.proxy.auth-demo.docker/)

Click **Set up Crowd** to start the setup wizard

* You should be presented with a system ID and prompted for a license key

Use [my.atlassian.com](https://my.atlassian.com/) to create a Data Center (trial) license for Crowd

Enter the license key and click **Continue**

On **Crowd installation**, select **New Installation**  and click **Continue**

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
* Username: (see output of `authdemo-show-secrets.sh` for `Crowd Admin`)
* Password: (see output of `authdemo-show-secrets.sh` for `Crowd Admin`)
* First name: `Crowd`
* Last name: `Admin`

Enter **Integrated applications** options and click **Next**:

* OpenID server: `[_]` (not yet needed)
