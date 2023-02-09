# Artifactory - Initialize Artifactory

## Set Admin Password

Open Artifactory at [https://artifactory.proxy.auth-demo.docker/](https://artifactory.proxy.auth-demo.docker/)

Login with the default credentials:

* Username: `admin`
* Password: `password`

Click on the **Admin** username in the top right, then **Edit Profile**

Unlock the profile using the password `password`

Click **Change Password**

Enter the following and click **Save**:

* **Email Address**: (your email address)
* **New Password**: (the value of **Artifactory Admin** from `./authdemo-show-secrets.sh`)

## Set Admin Password

At the top of the Artifactory UI, you should see this message:

>?No license found. If you have a license click
> [here](https://artifactory.proxy.auth-demo.docker/ui/admin/license_management/licenses)
> to activate. To purchase a license, visit our website or contact `sales@jfrog.com`.
> 

Follow the **here** link

Paste in the trial license key you've requested from JFrog.
