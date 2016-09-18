#!/bin/bash

# This is a shell script to destroy the "citus1OnPgCentos7" vm, only if it exists, so that the pipelines won't turn red.
# This script and others need re-factoring to parameterise vm name so that these could be used for other vms also.

TEMPSTR=`vagrant status | grep "citus1OnPgCentos7" | sed 's/citus1OnPgCentos7//g' | xargs`
if [ -z "$TEMPSTR" ]; then
  echo 'No such VM to destroy'
else
  echo 'destroying vm please wait...'
  vagrant destroy citus1OnPgCentos7 -f
fi

