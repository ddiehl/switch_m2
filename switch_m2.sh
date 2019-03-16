#!/bin/sh

echo "
 #================================================
 #  __  __ ___     _____         _ _       _     
 # |  \/  |__ \   / ____|       (_) |     | |    
 # | \  / |  ) | | (_____      ___| |_ ___| |__  
 # | |\/| | / /   \___ \ \ /\ / / | __/ __| '_ \ 
 # | |  | |/ /_   ____) \ V  V /| | || (__| | | |
 # |_|  |_|____| |_____/ \_/\_/ |_|\__\___|_| |_|
 #                                              
 # V2.0
 #================================================
                                               
"
SUFFIX=""

select_m2() {
	
	local current_m2=$(readlink  ~/.m2|rev|cut -d "/" -f1|rev|cut -d"_" -f 2)

	echo "0) Create new M2"
	local idx=1
	for file in $(ls -d ~/.m2_*)
	do 
		local val=$(echo $file|rev|cut -d "/" -f1|rev|cut -d"_" -f 2);
		#echo $file
		if [ "$val" != '.m2' ]
		then
			local crt_txt=""
			if [ "$current_m2" = "$val" ]
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
      if [[ -n ${selected//[0-(($idx))]/} ]]; then
         echo "Invalid Option select from 0 to $idx..."
      else 
      	if [ $selected = 0 ]
      	then
			read -p "Enter M2 suffix (name you want to call it): " NEW_M2
			echo $NEW_M2
			SUFFIX=$NEW_M2
      	else 
		   SUFFIX=${items[$selected]}
   			echo "Selected M2: $SUFFIX"
      	fi
        break;
      fi
   done
}

check_m2_is_link() {
	if [ -d ~/.m2 ]; then
		if [ ! -L ~/.m2 ]; then
			echo "Current m2 is not a link, perhaps you're running script for the first time."
			read -p "Give a name for you current m2: " CURRENT_M2_SFX
			echo $CURRENT_M2_SFX
			mv ~/.m2 ~/.m2_"$CURRENT_M2_SFX"  
			ln -s "~/.m2_$CURRENT_M2_SFX" ~/.m2
		fi
	fi
}

# BEGIN script main
check_m2_is_link
if [ $# != 1 ]
then
	select_m2
else
	SUFFIX=$1
fi



M2_FOLDER=~/.m2_$SUFFIX
if [ ! -d $M2_FOLDER ]; then
   echo "$M2_FOLDER does not exist, creating it"
   mkdir $M2_FOLDER
fi

echo "Switching .m2 to $M2_FOLDER"
mv ~/.m2 .m2_backup
ln -s "$M2_FOLDER" ~/.m2
echo "Switch complete m2 now points to $M2_FOLDER"

