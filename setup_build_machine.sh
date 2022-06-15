#!/bin/bash

sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm rsync curl zstd pzstd lz4c lz4

mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo "export PATH=~/bin:$PATH" >> ~/.bashrc

echo "Done. Please run the following commands to set up your git configuration."
echo "$ git config --global user.name 'Your Name'"
echo "$ git config --global user.email 'Your Email'"
