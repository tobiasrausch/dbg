#!/bin/bash

IDX=`echo ${HOSTNAME} | sed 's/^.*-//'`
while 1
do
    echo ${IDX}
done
