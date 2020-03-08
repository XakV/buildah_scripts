#!/bin/bash
cwc=$(buildah from f31/fedora-toolbox)
buildah run $cwc -- dnf install --nodocs --setopt=install_weak_deps=False -y git python3-pip
buildah run $cwc -- python3 -m pip install --upgrade pip
buildah run $cwc -- python3 -m pip install setuptools
buildah run $cwc -- git clone https://github.com/janeczku/calibre-web.git /srv
buildah run $cwc -- python3 -m pip install --target /srv/vendor -r /srv/requirements.txt
buildah run $cwc -- /usr/bin/mkdir -p /opt/Library 
#buildah config --cmd "python3 /srv/cps.py" $cwc
buildah config --cmd "/bin/bash" $cwc
buildah config --port 8083 $cwc
#buildah config --volume /home/zach/Media/Library:/opt/Library $cwc
buildah commit --rm --squash $cwc dbg-calibreweb

