# Basic Cluster Operations (Start/Stop/Wipe)

We (re)start the continers with:

```
bash restart.sh
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

We view the randomly generated passwords with:

```
bash show-secrets.sh
```