# Setup - Initialize Crowd

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
