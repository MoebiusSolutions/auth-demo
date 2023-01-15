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

We view the randomly generated passwords with:

```
bash show-secrets.sh
```
