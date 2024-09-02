#!/bin/sh

echo "
 #================================================
 #  __  __ ___     _____         _ _       _     
 # |  \/  |__ \   / ____|       (_) |     | |    
 # | \  / |  ) | | (_____      ___| |_ ___| |__  
 # | |\/| | / /   \___ \ \ /\ / / | __/ __| '_ \\
 # | |  | |/ /_   ____) \ V  V /| | || (__| | | |
 # |_|  |_|____| |_____/ \_/\_/ |_|\__\___|_| |_|
 #                                              
 # V2.2
 #================================================
                                               
"
SUFFIX=""
FOLDER_TYPE=".m2"
FOLDER_DESC="Maven"

select_folder() {
	
	local current_folder=$(readlink  ~/$FOLDER_TYPE|rev|cut -d "/" -f1|rev|cut -d"_" -f 2-)

	echo "0) Create new $FOLDER_DESC"
	local idx=1
	for file in $(ls -d ~/.m2_*)
	do 
		local val=$(echo $file|rev|cut -d "/" -f1|rev|cut -d"_" -f 2-);
		#echo $file
		if [ "$val" != "$FOLDER_TYPE" ]
		then
			local crt_txt=""
			if [ "$current_folder" = "$val" ]
			then 
				crt_txt=" (current)"
			fi
        	echo "$idx) $val$crt_txt"
			items[$idx]=$val
			((idx++))
		fi
	done
	echo "CTRL + C to exit"
	((idx--))
	while true; do
      read -p "Select POD [0-$idx]: " selected
      if [ -z "${selected##*[!0-9]*}" ] || [ "$selected" -lt 0 ] || [ "$selected" -gt "$idx" ]; then
         echo "Invalid Option select from 0 to $idx..."
      else 
      	if [ $selected = 0 ]
      	then
				read -p "Enter $FOLDER_DESC suffix (name you want to call it): " NEW_FOLDER
				SUFFIX=$NEW_FOLDER
      	else 
		   	SUFFIX=${items[$selected]}
   			echo "Selected $FOLDER_DESC: $SUFFIX"
      	fi
        break;
      fi
   done
}

check_folder_is_link() {
	if [ -d ~/$FOLDER_TYPE ]; then
		if [ ! -L ~/$FOLDER_TYPE ]; then
			echo "Current $FOLDER_DESC is not a link, perhaps you're running script for the first time."
			read -p "Give a name for you current m2: " CURRENT_FOLDER_SFX
			echo $CURRENT_FOLDER_SFX
			mv ~/$FOLDER_TYPE ~/$FOLDER_TYPE_"$CURRENT_FOLDER_SFX"  
			ln -s "~/$FOLDER_TYPE_$CURRENT_FOLDER_SFX" ~/$FOLDER_TYPE
		fi
	fi
}

# BEGIN script main
check_folder_is_link
if [ $# != 1 ]
then
	select_folder
else
	SUFFIX=$1
fi


NEW_FOLDER=~/$FOLDER_TYPE"_"$SUFFIX
if [ ! -d $NEW_FOLDER ]; then
   echo "$NEW_FOLDER does not exist, creating it"
   mkdir $NEW_FOLDER
fi

echo "Switching $FOLDER_DESC to $NEW_FOLDER"
rm ~/$FOLDER_TYPE
ln -s "$NEW_FOLDER" ~/$FOLDER_TYPE
echo "Switch complete $FOLDER_DESC now points to $NEW_FOLDER"

