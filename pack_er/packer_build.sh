#!/bin/bash

# This is a shell script to build the packer iso for VirtualBox and move the prepared box to ~/.vagrant.d/boxes folder
# to be used later by Vagrant to add the box.

cd pack_er
packer build -force buildvagrantbox.jason
mv packer_virtualbox-iso_virtualbox.box ~/.vagrant.d/boxes/.
ls -ltrh ~/.vagrant.d/boxes/.
vagrant box list

