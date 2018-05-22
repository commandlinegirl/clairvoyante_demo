
    echo 6 > .timeout
    while true; 
      do 
        sleep 1; 
        remaining_time=$(cat .timeout)
	echo remaining_time: $remaining_time
        if [[ $remaining_time == 0 ]]; then 
	   break;
	else 
	   echo $(($remaining_time - 1)) > .timeout
	fi
         
    done
