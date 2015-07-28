#!/bin/bash

# Vagrant specific
date > /etc/vagrant_box_build_time

# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

mkdir -p /home/vagrant/go
chown -R vagrant /home/vagrant/go

echo "export GOROOT=/usr/local/go" >> /home/vagrant/.bashrc
echo "export GOPATH=${HOME}/go" >> /home/vagrant/.bashrc
echo "export PATH=$PATH:/usr/local/go/bin:${GOPATH}/go/bin" >> /home/vagrant/.bashrc

# Customize the message of the day
echo 'Welcome! to Minio development Environment' > /etc/motd
