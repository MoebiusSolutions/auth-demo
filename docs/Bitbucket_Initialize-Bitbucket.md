# Bitbucket - Initialize Bitbucket

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

* Username: (see output of `authdemo-show-secrets.sh` for `Bitbucket Admin`)
* Full name: `Bitbucket Admin`
* Email address: (your email address)
* Password: (see output of `authdemo-show-secrets.sh` for `Bitbucket Admin`)

... and click **Go to Bitbucket**