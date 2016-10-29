#!/bin/bash

  # Sourcing all the environment variables
    source .env

    TEMPSTR1=$1;
    TEMPSTR2=$2;
    TEMPSTR3=$3;
    # Checking to see if verbose option was specified, else it will be left blank
    if [ "$4" == "v" ] || [ "$3" == "v" ]; then
        #TEMPSTR4="-vvvv"
        TEMPSTR4="-vvv"
    fi

    if [ -z "$TEMPSTR1" ] || [ -z "$TEMPSTR2" ]; then
	    if [ "$TEMPSTR1" != "rebuild" ] || [ "$TEMPSTR1" != "build" ]; then
		echo "                                                                                  "
		echo "   This script is to be able to Re-build (by destroying the VM and building all over)"
		echo "     Or to just build a VM (as in, re-run the yml's and fix anything if there has been a change"
		echo "                                                                                  "
		echo "  The script server.sh accepts 4 parameters"
		echo "    1st: 'rebuild' or 'build' a VM"
		echo "    2nd: Identify the vm that should be configured (ex: postgresql)"
		echo "    3rd: Specify if you want the vm to be built with a go-agent installed, options are:"
		echo "           with_gocd"
		echo "           without_gocd"
		echo "	     If this argument is left blank then the GoCD server and agents will not be installed"
		echo "    4th: Verbosity level of the ansible playbook executions, options are:"
		echo "           v => this would be at verbose level -vvv"
		echo "           If this argument is left blank then the verbosity level would be default"
		echo "                                                                                  "
		echo "   Examples:                                                                      "
		echo "  	1. Tear down and rebuild one particular vm, for Ex:"
		echo "  		./server.sh rebuild postgresql with_gocd v"
		echo "                                                                                  "
		echo "  	2. DO NOT Destroy but just re run the ansible scripts:"
		echo "  		./server.sh build postgresql with_gocd v"
		echo "                                                                                  "
		echo "  	3. Tear down and rebuild all the VMs at once:"
		echo "  		./server.sh rebuild all with_gocd"
		echo "                                                                                  "
		echo "  	4. DO NOT Destroy but just re run the ansible scripts on all VMs:"
		echo "  		./server.sh build all with_gocd v"
		echo "                                                                                  "
		echo "  	5. In all the above examples if you exclude the word "with_gocd" or if you"
		echo "  		replace it with "without_gocd" then the GoCD Server and agents will not be installed"
		echo "                                                                                  "
		exit;
	     fi
    fi

    case "$TEMPSTR2" in
      postgresql)
        VMNAME=$POSTGRESQL_VM_NAME
        ;;
      mysql)
        VMNAME=$MYSQL_VM_NAME
        ;;
      citusdata)
        VMNAME=$CITUSDATA_VM_NAME
        ;;
      all)
        VMNAME=all
        ;;
      *)
        echo $"Usage: $0 {postgresql|mysql|citusdata|all}"
        exit 1
    esac

    # Destroy/Tear down and boot up the server/s (without or without GoCD as per parameter 3:
        deploy_server/scripts/destroy_all_vm.sh $VMNAME $TEMPSTR3;
        deploy_server/scripts/vagrant_up.sh $VMNAME $TEMPSTR3

    # Executing the yml files to download, install and configure the selected server
        chmod 600 filesForVMs/insecure_citus1_pvt_key
        sleep 3

        if [ "$TEMPSTR2" == "all" ]; then
            ansible-playbook -i deploy_server/ansible_hosts deploy_server/${POSTGRESQL_VM_NAME}_playbook.yml $TEMPSTR4
            ansible-playbook -i deploy_server/ansible_hosts deploy_server/${MYSQL_VM_NAME}_playbook.yml $TEMPSTR4
            ansible-playbook -i deploy_server/ansible_hosts deploy_server/${CITUSDATA_VM_NAME}_playbook.yml $TEMPSTR4
        else
            ansible-playbook -i deploy_server/ansible_hosts deploy_server/${VMNAME}_playbook.yml $TEMPSTR4
        fi

        if [ "$TEMPSTR3" == "with_gocd" ]; then
            ansible-playbook -i deploy_server/ansible_hosts deploy_server/${GOCD_SERVER_VM_NAME}_playbook.yml $TEMPSTR4
            ansible-playbook -i deploy_server/ansible_hosts deploy_server/gocdAgentOnVM_playbook.yml
        fi

