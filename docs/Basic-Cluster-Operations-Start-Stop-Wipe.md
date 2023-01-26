# Basic Cluster Operations (Start/Stop/Wipe)

We (re)start the continers with:

```
./authdemo-redeploy.sh
```

We stop the cluster (deleting the stateless containers, but leaving volumes intact) with:

```
./authdemo-undeploy.sh
```

We stop and wipe the cluster (deleting all containers and volumes) with:

```
./authdemo-wipe.sh
```

We view the randomly generated passwords with:

```
./authdemo-show-secrets.sh
```

We can undeploy or redeploy a single container with:

```
# Undeploy (stop/delete)
./auth-demo-undeploy-container.sh <container-name>

# Redeploy (stop/delete/create/start, but retaining any volumes)
./auth-demo-redeploy-container.sh <container-name>
```
