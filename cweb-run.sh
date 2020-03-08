#!/bin/bash
/usr/bin/podman run --detach -p 8083:8083  --name=lbrry --mount type=bind,src=/home/zach/Media/Library,dst=/opt/Library,relabel=shared localhost/calibreweb python3 /srv/cps.py

