#!/bin/sh

NODE_VERSION=`node --version | tr -d v`
ARCH=`/bin/cat /etc/os-release | grep "VOLUMIO_ARCH" | cut -d \\" -f2 | tr -d "\n"`
if [ $ARCH = "armv7" ]; then
   ARCH="arm"
fi
NODE_MODULES_PACKAGE=/volumio/node_modules_${ARCH}-${NODE_VERSION}.tar.gz

if [ -f $NODE_MODULES_PACKAGE ]; then
   echo "Cleaning previous package file"
   rm $NODE_MODULES_PACKAGE
fi

cd /volumio

echo "Cleaning modules"
node /volumio/utils/misc/clean-node-modules.js /volumio

echo "Packing modules..."
tar zcf $NODE_MODULES_PACKAGE node_modules/
NODE_MODULES_PACKAGE_SIZE=`du -sbm ${NODE_MODULES_PACKAGE} | cut -f1`
echo "Done, package size ${NODE_MODULES_PACKAGE_SIZE} MB"
