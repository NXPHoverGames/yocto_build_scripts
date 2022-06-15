#!/bin/bash
set -x

# make sure cache writes have w other access
umask 0000

BUILD=`date +%Y%m%d.%H%M`; start=`date +%s`

mkdir -p build
cd build

repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-hardknott -m imx-5.10.72-2.2.0_desktop.xml
repo sync

# allow build to not prompt for input
sed 's/more\ -d/\#more\ -d/' setup-environment > x && mv -f x setup-environment

cd sources
git clone git@github.com:NXPHoverGames/NavQPlus.git meta-nxp-hovergames -b patches-bbappend
cd ..

DISTRO=imx-desktop-xwayland MACHINE=imx8mpnavq EULA=yes source ./imx-setup-desktop.sh -b build

bitbake-layers add-layer ../sources/meta-nxp-hovergames

bitbake imx-image-desktop

finish=`date +%s`; echo "### Build Time = `expr \( $finish - $start \) / 60` minutes"
