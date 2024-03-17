#!/bin/bash

start=`date +%s`
./build_base_dev.sh
./build_base_dev_debug.sh
end=`date +%s`

runtime=$((end-start))
printf "\n\nScript running time: %s sec\n\n" "$runtime";
