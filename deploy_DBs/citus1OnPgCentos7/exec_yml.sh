cd /Users/hmohan/centos7vm/deploy_DBs/citus1OnPgCentos7
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i citus1_ansible_hosts citus1_playbook.yml
