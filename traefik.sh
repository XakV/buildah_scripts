#!/bin/bash
tr=$(buildah from f31/fedora-toolbox)
traefik_rel=v2\.2\.0-rc1
buildah config --add-history $tr 
buildah run $tr -- wget -O /srv/traefik.tar.gz https://github.com/containous/traefik/releases/download/${traefik_rel}/traefik_${traefik_rel}_linux_amd64.tar.gz
buildah run $tr -- tar -xvf /srv/traefik.tar.gz
buildah run $tr -- rm -f /srv/traefik.tar.gz
buildah config --port 8080 --port 80 $tr
buildah config --annotation note=${traefik_rel} $tr
buildah config --cmd ./srv/traefik/traefik $tr
buildah add $tr '/home/zach/Containers/Configs/traefik.toml' '/srv/traefik/traefik.toml'
buildah commit --squash --rm $tr traefik
