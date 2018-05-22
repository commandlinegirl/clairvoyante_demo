#!/bin/bash

if [ -n "$1" ];
then 
	echo set instance type to $1
	INSTANCE_TYPE=$1
else
	echo no instance type set, using mem1_ssd1_x4
	INSTANCE_TYPE=mem1_ssd1_x4
fi

JOBID=$(dx run _clairvoyante_jupyter_demo --allow-ssh -y --brief --instance-type $INSTANCE_TYPE --priority normal)
i=0
while true; do
    (dx watch  --get-stderr --no-wait --no-job-info $JOBID 2> /dev/null | grep "Jupyter Notebook is running") && break
    state=$(dx describe $JOBID | grep State | tr -s ' ' | cut -d' ' -f 2 )
    echo "Waiting for the worker ($JOBID) to start up, unpacking asset and running Jupyter/$i,  $state"
    i=$((i+1))
    sleep 20
done
echo "Jupyter Notebook is running"
dx ssh --suppress-running-check $JOBID -o "StrictHostKeyChecking no" -f -L 2001:localhost:8888 -N
open http://localhost:2001/lab
