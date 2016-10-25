#!/bin/bash

# This is a shell script to destroy the "postgresqlOnCentos7" vm, only if it exists, so that the pipelines won't turn red.
# This script and others need re-factoring to parameterise vm name so that these could be used for other vms also.

TEMPSTR=`vagrant status | grep "postgresqlOnCentos7" | sed 's/postgresqlOnCentos7//g' | xargs`
if [ -z "$TEMPSTR" ]; then
  echo 'No such VM to destroy'
else
  echo 'destroying vm please wait...'
  vagrant destroy postgresqlOnCentos7 -f
fi

