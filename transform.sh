#!/usr/bin/env bash

# The object here is to clone the isle-imageservices repo, copy the contents of 
# transformations over it and patch the files that require patching.

# To work with AWS we need to patch the cantaloupe.properties file and introduce
# a confd variable, /base/domain, which equals the value of the BASE_DOMAIN env
# and will set cantaloupe's base_url property. 

[[ $CLONE_BASE ]] || CLONE_BASE=./isle-imageservices
OWD="${PWD}"
git clone https://github.com/Islandora-Collaboration-Group/isle-imageservices.git "${CLONE_BASE}"
cd "${CLONE_BASE}"
git fetch origin
git checkout -b ISLE-1.5.3 origin/ISLE-1.5.3
cp -r ../transformations/* "${CLONE_BASE}"
patch < Dockerfile.patch
cd rootfs/etc/confd/conf.d
patch < cantaloupe.toml.patch
cd ../templates/imageserv
patch < cantaloupe.properties.tpl.patch
cd "${OWD}"
find . -type f -iname \*.patch -delete
exit 0
