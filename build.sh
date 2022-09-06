#!/bin/bash

set -x

BUILD=`date +%Y%m%d.%H%M`; start=`date +%s`

mkdir -p ~/yocto/build_510
cd ~/yocto/build_510

repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-hardknott -m imx-5.10.72-2.2.0_desktop.xml
repo sync

cd ~/yocto/build_510/sources
git clone https://github.com/NXPHoverGames/NavQPlus.git -b lf5.10.72_2.2.2-ros2 meta-nxp-hovergames
cd ~/yocto/build_510

DISTRO=imx-desktop-xwayland MACHINE=imx8mpnavq EULA=yes source ./imx-setup-desktop.sh -b build

cd ~/yocto/build_510/build/conf
echo BBLAYERS += \"\${BSPDIR}/sources/meta-nxp-hovergames\" >> bblayers.conf
cd ~/yocto/build_510/build

bitbake imx-image-desktop

finish=`date +%s`; echo "### Build Time = `expr \( $finish - $start \) / 60` minutes"

set +x

