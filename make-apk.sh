#!/bin/sh
#
# Make Alpine Packages
#

set -xe

#
# remove all files not under git so they are not
# included in the distribution.
#
git clean -dxf


#
# make a distribution
#
./make-dist
mv -f *.tar.bz2 ./alpine

#
# alpine packaging key stuff
#
rm -rf .abuild && mkdir -p .abuild
ABUILD_USERDIR=$(pwd)/.abuild abuild-keygen -n -a
source .abuild/abuild.conf

#
# package it
#
cd alpine
abuild checksum && SRCDEST=$(pwd) REPODEST=$(pwd) PACKAGER_PRIVKEY=$PACKAGER_PRIVKEY abuild -r
cd ..
