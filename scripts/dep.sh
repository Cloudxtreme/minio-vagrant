#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update
apt-get -y install curl

# You can install anything you need here.
apt-get -y install git build-essential yasm
apt-get -y install wget
apt-get -y install emacs-nox 

wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
mkdir -p /usr/local
tar -C /usr/local -xzf go1.4.2.linux-amd64.tar.gz
rm -fv go1.4.2.linux-amd64.tar.gz
