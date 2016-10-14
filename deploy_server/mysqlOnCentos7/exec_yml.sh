cd /Users/hmohan/centos7vm/deploy_DBs/mysqlDB
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i mysql_ansible_hosts mysql_playbook.yml -vvvv
