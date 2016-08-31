If the vm is rebuilt:
   1. Edit your known_hosts file and remove the previous (stale) entry that was made for the vm under question.
   2. Try to ssh through port 2222 and make sure you are able to ssh without issues, this is required for the ansible scripts to function.
      a. Here is the command I use to connect and check date in vm:
          ssh -p 2222 vagrant@127.0.0.1 -i /Users/hmohan/.vagrant.d/insecure_private_key date
   3. Now you can execute the ansible script: time ansible-playbook postgresql_playbook.yml -i postgresql_ansible_hosts

There is a way to execute only portion of an ansible script, you have to use the flag '-t' and then pass it the tag name that you have used in the script.

