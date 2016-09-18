curl https://packages.citusdata.com/tutorials/citus-tutorial-linux-1.1.0.tar.gz > /home/postgres/citus-tutorial-linux-1.1.0.tar.gz
chown -R postgres:postgres /home/postgres
gunzip /home/postgres/citus-tutorial-linux-1.1.0.tar.gz
tar -xvf /home/postgres/citus-tutorial-linux-1.1.0.tar
chown -R postgres:postgres /home/postgres
