#!/bin/bash

# Querying the postgres database to check if citus extension is installed
#   The same is done by through the query "select * from pg_extention"
#   Output is then captured through cut -d OS command, look for the first column
#   Grep the same to look for the name of the extension which is 'citus'
#   Capture the output of this into a variable 'chk'
# Note: I am not using the database name while logging in through psql as it will default to the username which is 'citus1'
#   If it was not 'citus1' I would have used the option -d <dbname>
#   Also, port number to the command psql is coming through as a parameter passed to this script
  chk=`/home/citus1/citus-tutorial/bin/psql -t -p $1 -c "select * from pg_extension" | cut -d \| -f 1 | grep "citus"`;

  if [ $chk == "citus" ];
    then echo "0"; # denotes existance of citus extension
  else
    echo "1"; # denotes non existance of citus extension
  fi

