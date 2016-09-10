#!/bin/bash

# This is a shell script to build the packer iso for VirtualBox and move the prepared box to ~/.vagrant.d/boxes folder
# to be used later by Vagrant to add the box.

echo ---##---
echo ---##--- This is from within the packer_build.sh shell script:
echo Changing current folder to pack_er, because the Jason in the folder refers to a local folder 'http' that is within the pack_er folder
# Earlier I had faced a problem, as GoCD pipeline was executing the packer command from a folder which was parent to pack_er.
# Where it was not able to refer to the HTTP folder.
  cd pack_er

echo
echo Executing Packer command, this will take a few minutes, Please wait...
# Executing the Packer command to build a Virtual Box usable box file
  packer build -force buildvagrantbox.jason

echo
echo Moving the just generated box to folder from where Vagrant can use it
# Currently I have hardcoded the folder names, these are to be changed on a later date to be picked up through env variables.
  mv packer_virtualbox-iso_virtualbox.box ~/.vagrant.d/boxes/.

echo
echo List of files available currently in the boxes folder location for Vagrant to use
  ls -ltrh ~/.vagrant.d/boxes/.

echo
echo List of boxes currently registered with Vagrant before adding the newly generated box file through Packer
  vagrant box list

echo
echo Adding the newly generated box file to Vagrant
  vagrant box add --force --name 'custom_packer_built' ~/.vagrant.d/boxes/packer_virtualbox-iso_virtualbox.box

echo
echo Checking the list of boxes registered with Vagrant, once more
# A better way for this, is to catch the success or failure of the previous command and then check the output of this command and show messages
#  accordingly.
  vagrant box list

echo
echo ---##--- This is the end of packer_build.sh shell script execution.
echo ---##---

