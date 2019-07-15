#!/bin/bash

FILE=$4
httpss=$2
while [ ! $# -eq 0 ]
do
	case "$1" in
		-v )

			if [[ -f $FILE ]] && [[ $httpss = "http" ]];
			 then
				while read LINE; do

					echo $LINE;
					echo "-----------------------------------------------------------------" 
					used_IND=$(curl $httpss://$3  -I -H "host:  $LINE")
					echo "$LINE - $used_IND"
					echo "-----------------------------------------------------------------" 
				done < $FILE
			elif [[ -f $FILE ]] && [[ $httpss = "https" ]];
			 then
				while read LINE; do

					echo $LINE;
					echo "-----------------------------------------------------------------" 
					used_IND=$(curl $httpss://$LINE --resolve '$LINE:443:$3')
					echo "$LINE - $used_IND"
					echo "-----------------------------------------------------------------" 
				done < $FILE

			elif [[ ! -f $FILE ]] && [[ $httpss = "http" ]];
				then
					echo $FILE;
					echo "-----------------------------------------------------------------" 
					used_IND=$(curl $httpss://$3  -I -H "host:  $FILE")
					echo "$FILE - $used_IND"
					echo "-----------------------------------------------------------------"

			elif [[ ! -f $FILE ]] && [[ $httpss = "https" ]];
				then
					echo $FILE;
					echo "-----------------------------------------------------------------" 
					used_IND=$(curl $httpss://$FILE --resolve "'$FILE:443:$3'")
					echo "$FILE - $used_IND"
					echo "-----------------------------------------------------------------"
			fi
			exit
			;;
		-nv )

			if [[ -f $FILE ]] ;
			 then
				while read LINE; do

					used_IND=$(curl $2://$3 -I -o /dev/null -sw '%{http_code}\n' -H "host:  $LINE")
					echo " $LINE - $used_IND"
			    		echo "-----------------------------------------------------------------" 

				done < $FILE

			else

					used_IND=$(curl $2://$3 -I -o /dev/null -sw '%{http_code}\n' -H "host:  $FILE")
					echo " $FILE - $used_IND"
			    		echo "-----------------------------------------------------------------" 
			fi
			exit
			;;

	esac
	shift
done
