#!/bin/bash

if ! test -f db.txt
  then
       touch db.txt     
fi

flag="1"
if [ $1 = "" ]
  then
    echo "please enter option : -i , -v, -s , -e , -d " 
    flag="2"
 
  else
    while [ $flag = 1 ]
        do
	case $1 in

	-i)     #insert option
           
           read -p "enter contact name:  " name
           old_contact=`grep "^$name"  db.txt` 
           if  grep "^$name"  db.txt
               then
                    echo "already exist ..."
                    read -p  "Do you want to add another number for this name ? enter Y/N ..."  n
                    if [ $n = Y ]
                       then 
                           read -p "enter contact number:  " number
                           line_number=`grep -n "^$name"  db.txt | awk -F: '{print $1}' | sort -u`                      
                           line_number="${line_number: -1}"
                           sed  -i "${line_number}d" db.txt
	                   echo  $old_contact      $number  >> db.txt                                
                    fi
           else 
                    read -p "enter contact number:  " number
	            echo  $name      $number  >> db.txt                    
           fi                               
           ;; 


	-v)     #view option
	  
             cat db.txt;;

	-s)     #search option

	   read -p "enter contact name to search:  " name
           if  ! grep "^$name"  db.txt 
               then
                    echo "not exist"  
           fi                      
           ;;

	-e)  #delete all - option
	 
            echo -n "" > db.txt;;

	-d)   #delete option
	  
           read -p "enter contact name to delete:  " name
           if  ! grep "^$name"  db.txt  
               then
                    echo "not exist"  
           else                  
                    line_number=`grep -n "^$name"  db.txt | awk -F: '{print $1}' | sort -u`                      
                    line_number="${line_number: -1}"
                    #echo  $line_number
                    sed  -i "${line_number}d" db.txt  

           fi                      
           ;;

	esac 

        read -p "enter c if you want to close prog:  " n

        if [ $n = c ]
        then
             flag="2"
        fi
   done

fi 


