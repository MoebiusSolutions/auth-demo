# NISE Authentication Demo (nise-auth-demo)

## Repo Identity

At the time of this writing, this project was hosted at
[gitlab.moesol.com/rkenney/nise-auth-demo](https://gitlab.moesol.com/rkenney/nise-auth-demo)

## Getting Started

1. Create `.env` (and tweak settings if necessary):

   ```
   cp .env.template .env
   ```

1. Start the cluster, per [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md):

   ```
   bash restart.sh
   ```

2. View auto-generated passwords, per [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md):

   ```
   bash show-secrets.sh
   ```

3. Follow [Initialize Crowd](docs/Setup_Initialize-Crowd.md)

4. Follow [Initialize Bitbucket](docs/Setup_Bitbucket-Crowd.md)

## Service Links

* Bitbucket: [http://127.0.0.1:7990/](http://127.0.0.1:7990/)
* Bitbucket SSH: [http://127.0.0.1:7999/](http://127.0.0.1:7999/)
* Crowd: [http://127.0.0.1:8095/](http://127.0.0.1:8095/)
* OpenLDAP UI [https://127.0.0.1:8443/](https://127.0.0.1:8443/)

## Docs

* [Basic Cluster Operations (Start/Stop/Wipe)](docs/Basic-Cluster-Operations-Start-Stop-Wipe.md)
* [Setup - Initialize Crowd](docs/Setup_Initialize-Crowd.md)
* [Setup - Initialize Bitbucket](docs/Setup_Initialize-Bitbucket.md)
* [Manual Actions in LDAP UI](docs/Manual-Actions-in-LDAP-UI.md)
* [Manual Actions in LDAP CLI](docs/Manual-Actions-in-LDAP-CLI.md)
