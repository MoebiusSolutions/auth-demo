# Getting Started

1. You can either use two different browsers (e.g. Chrome vs Firefox)
   or create two different browser profiles,
   but you will likely want two different contexts you can run from:

    * A context where the non-SSO admin user is used for each service
    * A context where a sample SSO user is logged in

2. Create `.env` (tweak settings if necessary, but defaults generally OK):

   ```
   cp .env.template .env
   ```

3. Copy the output of the following command into your `/etc/hosts` file
   (allowing the host browser to resolve the docker hosts):

   ```
   ./authdemo-show-hosts.sh
   ```

4. Start the cluster (see [Basic Cluster Operations](Basic-Cluster-Operations-Start-Stop-Wipe.md) for more info):

   ```
   ./authdemo-redeploy.sh
   ```

5. View the auto-generated passwords:

   ```
   ./authdemo-show-secrets.sh
   ```

6. Save a copy of CA cert:

   ```
   sudo docker compose run -it --rm secrets cat /secrets/certs/ca-shared/root-ca.crt > root-ca.crt
   ```

   ... and then load the file into your browser(s) as a Certificate Authority

7. Verify that you are able to hit the Keycloak server:
   [https://keycloak.proxy.auth-demo.docker/](https://keycloak.proxy.auth-demo.docker/)
