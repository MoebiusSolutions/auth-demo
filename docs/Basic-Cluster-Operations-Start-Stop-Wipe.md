# Basic Cluster Operations (Start/Stop/Wipe)

We (re)start the continers with:

```
bash redeploy.sh
```

We stop the cluster (deleting the stateless containers, but leaving volumes intact) with:

```
bash undeploy.sh
```

We stop and wipe the cluster (deleting all containers and volumes) with:

```
bash wipe.sh
```

We view the randomly generated passwords with:

```
bash show-secrets.sh
```

We can redeploy a single container (stop, delete, create--but retaining any volumes) with:

```
bash redeploy-container.sh <container-name>
```
