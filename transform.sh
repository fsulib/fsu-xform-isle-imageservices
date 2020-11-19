#!/usr/bin/env bash

# The object here is to clone the isle-imageservices repo, copy the contents of 
# transformations over it and patch the files that require patching.

# isle-imageservices requires no patches, just the new delegates.rb template file

[[ $CLONE_BASE ]] || CLONE_BASE=./isle-imageservices
OWD="${PWD}"
git clone https://github.com/Islandora-Collaboration-Group/isle-imageservices.git "${CLONE_BASE}"
cp -r transformations/* "${CLONE_BASE}"
cd "${CLONE_BASE}"
patch < Dockerfile.patch
find . -type f -iname \*.patch -delete
cd "${OWD}"
exit 0
