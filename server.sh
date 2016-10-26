#!/bin/bash

# This script is to be able Re-build (by destroying the VM and building all over)
#   Or to just build a VM (as in re-run the yml's and fix anything if there has been a change
#
# Currently this script expects 3 arguments:
#   1: 1st argument tells the script to 'rebuild' or 'build' a VM
#   2: 2nd arguments is to mention the VM that has to be dealt with
#   3: 3rd argument is for the execution of the Anisble-playbook, if the 3rd argument is empty then the playbooks are run 'without verbosity'
#       If the 3rd argument is 'v' then the playbooks are run with 'vvvv' verbosity.

  TEMPSTR1=$1;
  if [ -z "$TEMPSTR1" ]; then
    echo "  Please execute this bash script with right parameters"
    echo "  Allowed options for the 1st parameter are: 'build', 'rebuild'"
    echo "  Example: ./server.sh rebuild postgresql"
    exit;
  else
    TEMPSTR2=$2;
    if [ -z "$TEMPSTR2" ]; then
      echo "  Please execute this bash script with right parameters"
      echo "  Allowed options for the 2nd parameter are: 'postgresql', 'mysql', 'citusdata', 'gocd_server'"
      echo "  Example: ./server.sh rebuild postgresql"
      exit;
    fi

    case "$TEMPSTR2" in
      postgresql)
        VMNAME="postgresqlOnCentos7"
        ;;
      mysql)
        VMNAME="mysqlOnCentos7"
        ;;
      citusdata)
        VMNAME="citus1OnPgCentos7"
        ;;
      gocd_server)
        VMNAME="gocdOnCentos7"
        ;;
      *)
        echo $"Usage: $0 {postgresql|mysql|citusdata|gocd_server}"
        exit 1
    esac

    if [ "$TEMPSTR1" == "rebuild" ]; then
      # Destroy and rebuild the vm as per the parameter passed
        time vagrant destroy -f $VMNAME
    fi
  fi

  # In case the VM is currently shutdown, this next line will try to bring it up before executing the Ansible Playbooks
      time vagrant up $VMNAME

  # Executing the yml files to download, install and configure the selected server
      if [ "$3" == "v" ]; then
        #TEMPSTR3="-vvvv"
        TEMPSTR3="-vvv"
      fi
	chmod 600 filesForVMs/insecure_citus1_pvt_key
        export ANSIBLE_HOST_KEY_CHECKING=False
        if [ "$TEMPSTR2" == "postgresql" ]; then
	  sleep 3
          time ansible-playbook -i deploy_server/ansible_hosts deploy_server/postgresqlOnCentos7_playbook.yml $TEMPSTR3
        fi
        if [ "$TEMPSTR2" == "mysql" ]; then
	  sleep 3
          time ansible-playbook -i deploy_server/ansible_hosts deploy_server/mysqlOnCentos7_playbook.yml $TEMPSTR3
        fi
        if [ "$TEMPSTR2" == "citusdata" ]; then
	  sleep 3
          time ansible-playbook -i deploy_server/ansible_hosts deploy_server/citus1_playbook.yml $TEMPSTR3
        fi
        if [ "$TEMPSTR2" == "gocd_server" ]; then
	  sleep 3
          time ansible-playbook -i deploy_server/ansible_hosts deploy_server/installgocd_playbook.yml $TEMPSTR3
        fi

