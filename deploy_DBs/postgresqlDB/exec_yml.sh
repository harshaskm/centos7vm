cd /Users/hmohan/centos7vm/deploy_DBs/postgresqlDB
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i postgresql_ansible_hosts postgresql_playbook.yml -vvvv
