#!/bin/bash
if [ ! -f jars/dxWDL-0.65.jar ]; then
   pushd jars
   wget https://github.com/dnanexus/dxWDL/releases/download/0.65/dxWDL-0.65.jar
fi

dx mkdir -p applets
dx cd applets
dx build _clairvoyante_jupyter_demo/ -f
pushd cv_prepare_training_data
bash build-applet.sh
popd
dx build cv_training/ -f
pushd cv_variant_calling/
bash build-applet.sh
popd
