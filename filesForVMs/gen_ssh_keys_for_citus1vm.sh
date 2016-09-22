rm -rf /tmp/.ssh
mkdir -p /tmp/.ssh
ssh-keygen -t rsa -f /tmp/.ssh/id_rsa -q -N "" -C noname
cp /tmp/.ssh/id_rsa insecure_citus1_pvt_key
cp /tmp/.ssh/id_rsa.pub put_into_citus1vm_auth_key

