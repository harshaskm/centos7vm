#!/bin/bash

# Script to boot VMs configured through the Vagrantfile.
# I need to parameterize this script or use env variables to remove the hardcoding of the VM names:

    TEMPSTR1=$1;
    TEMPSTR2=$2;

    if [ -z "$TEMPSTR1" ]; then
        echo "                                                                                   "
        echo "  The script accepts 2 parameters"
        echo "    1st: 'all' which would mean to boot up all the VMs configured through the Vagrantfile"
        echo "         Or it should be a VM name (for ex: postgresqlOnCentos7)"
        echo "    2nd: Specify if you want this script to boot up GoCD server, options are:"
        echo "           with_gocd"
        echo "           without_gocd"
        echo "           If this argument is left blank then the script will not boot up the GoCD server"
        echo "                                                                                   "
        echo "  Examples: 									     "
        echo "            1. Boot up all the VMs defined in Vagrantfile including GoCD server:"
        echo "			 ./vagrant_up.sh all with_gocd"
        echo "	      2. Boot up all the VMs defined in the Vagrantfile excluding GoCD server:"
        echo "            		 ./vagrant_up.sh all without_gocd"
        echo "	      3. Boot up only Postgresql server with GoCD server:"
        echo "  	      	 	 ./vagrant_up.sh postgresqlOnCentos7 with_gocd"
        echo "	      4. Boot up only Postgresql server without GoCD server:"
        echo "  	      		 ./vagrant_up.sh postgresqlOnCentos7 without_gocd"
        echo "                                                                                   "
        exit;
    else
        if [ "$TEMPSTR2" == "with_gocd" ]; then
            vagrant up gocdOnCentos7
        fi

        if [ "$TEMPSTR1" == "all" ]; then
                for vmname in $ALL_VMS_EXCEPT_GO
                do
                    TEMPSTR3=`vagrant status | grep "$vmname" | sed 's/$vmname//g' | xargs`
                    if [ -z "$TEMPSTR3" ]; then
                      echo 'No such VM to boot up'
                    else
                      vagrant up $vmname
                    fi
                done
        else
            vagrant up $TEMPSTR1
        fi
    fi

