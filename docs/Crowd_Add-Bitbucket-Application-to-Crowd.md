# Crowd - Add Bitbucket Application to Crowd

Open [http://crowd.proxy.auth-demo.docker/](http://crowd.proxy.auth-demo.docker/) and login as admin

Click **Applications**, then click **Add application**

Enter the following into **Add application** and click **Next**:

* Application type: `Bitbucket Server`
* Name: (see `Crowd/Bitbucket App Connector` name from `authdemo-show-secrets.sh`)
* Password: (see `Crowd/Bitbucket App Connector` password from `authdemo-show-secrets.sh`)

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
