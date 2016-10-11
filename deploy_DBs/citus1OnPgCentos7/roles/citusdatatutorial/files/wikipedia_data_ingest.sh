#!/bin/bash


#This is a custom script built to execute the citus-tutorial script "wikipedia-user-data"
#	For 100 seconds, so that data is collected onto the postgres database during that time
#	To be queried to ascertain how data is placed in the cluster

cd /home/citus1/citus-tutorial/
timeout 100s scripts/collect-wikipedia-user-data postgresql://:$1
