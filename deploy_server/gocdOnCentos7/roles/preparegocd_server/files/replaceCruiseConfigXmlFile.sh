#!/bin/bash

cp /etc/go/cruise-config.xml /etc/go/cruise-config.xml.bak

sed -n -e 1p /etc/go/cruise-config.xml > /etc/go/cruise-config.xml.rep
sed -n -e 2p /etc/go/cruise-config.xml >> /etc/go/cruise-config.xml.rep
stringZ=`sed -n '3p' < /etc/go/cruise-config.xml` && numY="$((${#stringZ} - 3))" && echo " " ${stringZ:0:$(($numY))}\> >> /etc/go/cruise-config.xml.rep
sed -n -e 4p /etc/go/cruise-config.xml >> /etc/go/cruise-config.xml.rep

cat /etc/go/cruise-config.xml.rep > /etc/go/cruise-config.xml

cat /etc/go/cruise-config.xml

