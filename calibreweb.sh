#!/bin/bash
cwc=$(buildah from fedora)
buildah run $cwc -- dnf install --nodocs --setopt=install_weak_deps=False -y git python3-pip
buildah run $cwc -- python3 -m pip install --upgrade pip
buildah run $cwc -- python3 -m pip install setuptools
buildah run $cwc -- git clone https://github.com/janeczku/calibre-web.git /srv
buildah run $cwc -- python3 -m pip install --target /srv/vendor -r /srv/requirements.txt
buildah config --cmd "python3 /srv/cps.py" $cwc
buildah config --port 8083 $cwc
buildah config --volume $HOME/Media/Library $cwc
buildah commit --rm --squash $cwc calibreweb

