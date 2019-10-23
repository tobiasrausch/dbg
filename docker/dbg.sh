#!/bin/bash

IDX=`echo ${HOSTNAME} | sed 's/^.*-//'`
while true
do
    echo ${IDX}
    sleep 5
done
