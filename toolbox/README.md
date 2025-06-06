# Creates a container for development

Uses [Toolbx](https://containertoolbx.org) to setup a development container

## Prerequisites

Requires host to have:

- podman
- toolbox

Tools that are not required but will only work if installed on host are

- docker
- helm
- kubectl
- cloud-sql-proxy
- flatpak
- distrobox
- code
- tilt
- gcloud
- xrandr
- wmcrtl

## Setting up
```
podman build -t devs-image --label=devbox -f Dockerfile .
toolbox create --image devs-image devs
toolbox enter devs
```

## Removing

```
podman stop devs
toolbox rm devs
toolbox rmi devs-image
```
