# NISE Authentication Demo (nise-auth-demo)

## Basic Cluster Start/Stop/Wipe

We create/launch the continers with:

```
bash start.sh
```

We stop the cluster (deleting the stateless containers, but leaving volumes intact) with:

```
bash stop.sh
```

We stop and wipe the cluster (deleting all containers and volumes) with:

```
bash wipe.sh
```

**ATTENTION**: You may want to be careful not to wipe after you have licensed Atlassian products.
I am not yet sure how easy it is to setup a new trial license if the server ID changes.

## Setting Up Products

Initial Setup

* [Setup - Initialize Crowd](docs/Setup_Initialize-Crowd.md)
* [Setup - Bitbucket Crowd](docs/Setup_Bitbucket-Crowd.md)

## Other Notes

* [Manual Actions in LDAP UI](docs/Manual-Actions-in-LDAP-UI.md)
* [Manual Actions in LDAP CLI](docs/Manual-Actions-in-LDAP-CLI.md)
