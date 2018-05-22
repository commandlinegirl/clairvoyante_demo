#!/bin/bash

main() {
    #set -ex
    sudo chmod 755 /etc/notebook/start-notebook.sh
    sudo chmod 755 /etc/notebook/start-notebook2.sh
    sudo chmod 755 /etc/notebook/install_anaconda2.sh
    sudo -u dnanexus /etc/notebook/start-notebook2.sh

    echo 50 > /home/dnanexus/.timeout
    while true; 
      do 
        sleep 60; 
        remaining_time=$(cat /home/dnanexus/.timeout)
	echo remaining_time: $remaining_time
        if [[ $remaining_time -lt 0 ]]; then 
	   break;
	else 
	   echo $(($remaining_time - 1)) > /home/dnanexus/.timeout
	fi
      done;
    exit 0
}
