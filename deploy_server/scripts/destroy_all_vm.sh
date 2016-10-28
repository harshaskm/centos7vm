#!/bin/bash

	TEMPSTR1=$1;
	TEMPSTR2=$2;

	if [ -z "$TEMPSTR1" ]; then
	    echo "                                                                                   "
	    echo "  The script accepts 2 parameters"
	    echo "    1st: 'all' which would mean to boot up all the VMs configured through the Vagrantfile"
	    echo "         Or it should be a VM name (for ex: postgresqlOnCentos7)"
	    echo "    2nd: Specify if you want this script to destroy GoCD server, options are:"
	    echo "           with_gocd"
	    echo "           without_gocd"
	    echo "           If this argument is left blank then the script will not destroy the GoCD server"
	    echo "                                                                                   "
	    echo "  Examples: 									     "
	    echo "        1. Destroy all the VMs defined in Vagrantfile including GoCD server:"
	    echo "			         ./destroy_all_vm.sh all with_gocd"
	    echo "                                                                                   "
	    echo "	      2. Destroy all the VMs defined in the Vagrantfile excluding GoCD server:"
	    echo "            		 ./destroy_all_vm.sh all without_gocd"
	    echo "                                                                                   "
	    echo "	      3. Destroy only Postgresql server with GoCD server:"
	    echo "  	      	 	 ./destroy_all_vm.sh postgresqlOnCentos7 with_gocd"
	    echo "                                                                                   "
	    echo "	      4. Destroy only Postgresql server without GoCD server:"
	    echo "  	      		 ./destroy_all_vm.sh postgresqlOnCentos7 without_gocd"
	    echo "                                                                                   "
	    exit;
	fi

    if [ "$TEMPSTR1" == "all" ]; then
            for vmname in $ALL_VMS_EXCEPT_GO
            do
                TEMPSTR3=`vagrant status | grep "$vmname" | sed 's/$vmname//g' | xargs`
                if [ -z "$TEMPSTR3" ]; then
                  echo 'No such VM to destroy'
                else
                  vagrant destroy $vmname -f
                fi
            done
    else
		TEMPSTR3=`vagrant status | grep "$TEMPSTR1" | sed 's/$TEMPSTR1//g' | xargs`
		if [ -z "$TEMPSTR3" ]; then
		  echo 'No such VM to destroy'
		else
		  vagrant destroy $TEMPSTR1 -f
		fi
    fi

	if [ "$TEMPSTR2" == "with_gocd" ]; then
		TEMPSTR3=`vagrant status | grep "gocdOnCentos7" | sed 's/gocdOnCentos7//g' | xargs`
		if [ -z "$TEMPSTR3" ]; then
		  echo 'No such VM to destroy'
		else
		  echo 'destroying GoCD Server please wait...'
		  vagrant destroy gocdOnCentos7 -f
		fi
    fi
