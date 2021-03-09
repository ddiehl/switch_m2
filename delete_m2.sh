#!/bin/sh

echo "
 #=========================================================
 #
 # 
 #  __  __ ____    ____                                _ 
 # |  \/  |___ \  |  _ \ ___ _ __ ___   _____   ____ _| |
 # | |\/| | __) | | |_) / _ \ '_   _ \ / _ \ \ / / _  | |
 # | |  | |/ __/  |  _ <  __/ | | | | | (_) \ V / (_| | |
 # |_|  |_|_____| |_| \_\___|_| |_| |_|\___/ \_/ \__,_|_|
 #                                                              
 #
 # V1.0
 #=========================================================
                                               
"
SUFFIX=""
FOLDER_TYPE=.m2
FOLDER_DESC=m2

select_folder() {
	
	local current_link=$(readlink  ~/$FOLDER_TYPE|rev|cut -d "/" -f1|rev|cut -d"_" -f 2)

	local idx=0
	for file in $(ls -d ~/"$FOLDER_TYPE"_*)
	do 
		local val=$(echo $file|rev|cut -d "/" -f1|rev|cut -d"_" -f 2);
		#echo $file
		if [ "$val" != "$FOLDER_TYPE" ]
		then
			local crt_txt=""
			if [ "$current_link" != "$val" ]
			then 
	        	echo "$idx) $val$crt_txt"
				items[$idx]=$val
				((idx++))
			fi

		fi
	done
	echo "CTRL + C to exit"
	((idx--))
	while true; do
      read -p "Select POD [0-$idx]: " selected
      echo "Selected: $selected"
      if [ -z "${selected##*[!0-9]*}" ] || [ "$selected" -lt 0 ] || [ "$selected" -gt "$idx" ]; then
		echo "Invalid Option select from 0 to $idx..."
      else 
		SUFFIX=${items[$selected]}
   		echo "Selected $FOLDER_DESC: $SUFFIX"
        break;
      fi
   done
}

# BEGIN script main
if [ $# != 1 ]
then
	select_folder
else
	SUFFIX=$1
fi


CURRENT_FOLDER=~/${FOLDER_TYPE}_$SUFFIX
if [ ! -d $CURRENT_FOLDER ]; then
   echo "$CURRENT_FOLDER does not exist, aborting it."
   exit 1
fi

echo "Deleting :FOLDER_DESC: $CURRENT_FOLDER"
rm -rf "$CURRENT_FOLDER"
echo "Deletion complete."

