#!/bin/bash

set -x

BUILD=`date +%Y%m%d.%H%M`; start=`date +%s`

pwd
mkdir -p ~/yocto/build_515
cd ~/yocto/build_515
pwd

repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-kirkstone -m imx-5.15.32-2.0.0_desktop.xml
repo sync

cd ~/yocto/build_515/sources
git clone https://github.com/NXPHoverGames/NavQPlus.git -b lf5.15.32_2.0.0-ros2 meta-nxp-hovergames
cd ~/yocto/build_515

DISTRO=imx-desktop-xwayland MACHINE=imx8mpnavq EULA=yes source ./imx-setup-desktop.sh -b build

cd ~/yocto/build_515/build/conf
echo BBLAYERS += \"\${BSPDIR}/sources/meta-nxp-hovergames\" >> bblayers.conf
cd ~/yocto/build_515/build

bitbake imx-image-desktop

finish=`date +%s`; echo "### Build Time = `expr \( $finish - $start \) / 60` minutes"

set +x
