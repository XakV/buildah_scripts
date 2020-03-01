#!/bin/bash
podman pull registry.fedoraproject.org/f31/python3
cwl=$(buildah from 1641c1780e9f)
buildah unshare
#TODO - run the git clone command here OR
# something else?
buildah run $l pip3 install --target vendor -r /srv/requirements.txt
buildah config --cmd "['python3', '/srv/cps.py']" $l
buildah config --port 8083 $l
buildah config --volume $HOME/Media/Library $l
buildah commit --rm $l calibreweb
podman images
#REPOSITORY                               TAG      IMAGE ID       CREATED          SIZE
#localhost/calibreweb                     latest   0bcee6174b79   20 minutes ago   1.12 GB
#registry.fedoraproject.org/f31/python3   latest   1641c1780e9f   2 weeks ago      940 MB

