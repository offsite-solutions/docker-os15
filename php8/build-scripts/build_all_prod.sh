#!/bin/bash

start=`date +%s`
./build_base_nodb.sh
./build_base_oci8.sh
./build_base_pgsql.sh
./build_base_sqlsrv.sh
end=`date +%s`

runtime=$((end-start))
printf "\n\nScript running time: %s sec\n\n" "$runtime";
