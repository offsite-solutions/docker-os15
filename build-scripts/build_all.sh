#!/bin/bash
if [ -n "$1" ]; then VER=$1; else VER=latest; fi;

start=`date +%s`
./build_base.sh $VER
./build_base_dev.sh $VER
./build_base_dev_debug.sh $VER
./build_base_oci8.sh $VER
./build_base_pgsql.sh $VER
./build_base_sqlsrv.sh $VER
end=`date +%s`

runtime=$((end-start))
printf "\n\nScript running time: %s sec\n\n" "$runtime";
