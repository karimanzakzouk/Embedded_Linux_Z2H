#!/bin/bash

if ! test -d ~/TRASH 
  then
       mkdir ~/TRASH    
fi
 

if [ $1 = "" ]
  then
     echo "please enter file or folder name " 
 
  else
     
       #check file or folder and zip or not 
        if [[ -d $1 ]]; then
	   echo "$1 is a directory"
           if file --mime-type "$1" | grep -q zip$; then
	    	echo "$1 is zipped"
            	mv -v $1 ~/TRASH
               
	   else
	    	echo "$1 is not zipped"
                zip $1.zip $1
            	mv -v $1.zip ~/TRASH
                rm -r $1
	   fi           

	elif [[ -f $1 ]]; then
	    echo "$1 is a file"
            if file --mime-type "$1" | grep -q zip$; then
	   	echo "$1 is zipped"
            	mv $1 ~/TRASH
                
	    else
	        echo "$1 is not zipped"
                zip $1.zip $1
                mv $1.zip ~/TRASH 
                rm $1
	    fi
            
	else
	        exit 1
	fi

    find ~/TRASH -mtime +2 -type f -exec  rm -r {} \;	

fi



