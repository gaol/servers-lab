#!/bin/sh

version=$1

if [ "$version" == "" ]; then
  version="5.1.22"
fi

markfile="/usr/share/vboxguest.installed"
if [ -e "${markfile}" ]; then
  cat $markfile
  exit
fi
url="http://download.virtualbox.org/virtualbox/${version}/VBoxGuestAdditions_${version}.iso"
curl -s -o VBoxGuestAdditions.iso $url 
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions

sudo echo -e "VBoxGuestAdditions ${version} installed" > $markfile
cat $markfile
