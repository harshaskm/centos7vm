#!/bin/bash

# This is a shell script to destroy the "mysqlOnCentos7" vm, only if it exists, so that the pipelines won't turn red.
# This script and others need re-factoring to parameterise vm name so that these could be used for other vms also.

TEMPSTR=`vagrant status | grep "mysqlOnCentos7" | sed 's/mysqlOnCentos7//g' | xargs`
if [ -z "$TEMPSTR" ]; then
  echo 'No such VM to destroy'
else
  echo 'destroying vm please wait...'
  vagrant destroy mysqlOnCentos7 -f
fi

