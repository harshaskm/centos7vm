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
        echo "  postgresql vm will be rebuilt"
        VMNAME="postgresqlOnCentos7"
        ;;
      mysql)
        echo "  Mysql vm will be rebuilt"
        VMNAME="mysqlOnCentos7"
        ;;
      citusdata)
        echo "  Mysql vm will be rebuilt"
        VMNAME="citus1OnPgCentos7"
        ;;
      gocd_server)
        echo "  GoCD Server vm will be rebuilt"
        VMNAME="gocdOnCentos7"
        ;;
      *)
        echo $"Usage: $0 {postgresql|mysql|citusdata|gocd_server}"
        exit 1
    esac

    if [ "$TEMPSTR1" == "rebuild" ]; then
      # Destroy and rebuild the vm as per the parameter passed
        time vagrant destroy -f $VMNAME
        time vagrant up $VMNAME
    fi
  fi

  # Executing the yml files to download, install and configure the selected server
  TEMPSTR1=$3;
  if [ "$TEMPSTR3" == "v" ]; then
    TEMPSTR3 = "-vvvv";
  fi
    cd /Users/hmohan/centos7vm/deploy_server/$VMNAME
    export ANSIBLE_HOST_KEY_CHECKING=False
    if [ "$TEMPSTR2" == "postgresql" ]; then
      time ansible-playbook -i postgresql_ansible_hosts postgresql_playbook.yml $TEMPSTR3
    fi
    if [ "$TEMPSTR2" == "mysql" ]; then
      time ansible-playbook -i mysql_ansible_hosts mysql_playbook.yml $TEMPSTR3
    fi
    if [ "$TEMPSTR2" == "citusdata" ]; then
      time ansible-playbook -i citus1_ansible_hosts citus1_playbook.yml
      time ansible-playbook -i citus1_tutorial_hosts citus1_tutorial_playbook.yml $TEMPSTR3
    fi
    if [ "$TEMPSTR2" == "gocd_server" ]; then
      time ansible-playbook -i preparegocd_ansible_hosts preparegocd_playbook.yml $TEMPSTR3
      time ansible-playbook -i installgocd_ansible_hosts installgocd_playbook.yml $TEMPSTR3
    fi

