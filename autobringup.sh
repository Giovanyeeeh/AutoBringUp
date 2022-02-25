#!/bin/bash
# Autor: Broly
# License: GNU General Public License v3.0
# https://www.gnu.org/licenses/gpl-3.0.txt
clear
cat << "EOF"
#####################
#    AUTOBRINGUP    # 
#####################
EOF
printf "\n\n"
printf "WARNING MAKE SURE TO ENTER THE CORRECT ROM NAME\n OR IT WILL RENAME SOME FILES WRONGLY!!!\n\n"
read -r -p "Please enter the name of the old rom: " oldrom
read -r -p "Now please enter the name of the new rom: " newrom
printf "\n\n"

if [[ -d "device/motorola/ocean" ]]; then
	cd device/motorola/ocean || exit
else
	printf "path to device doesn't exist!!\n"
	exit 1
fi

if [[ -f "$oldrom.dependencies" ]]; then
	mv "$oldrom".dependencies "$newrom".dependencies || :
else 
	printf "There's no file .dependencies in /device/motorola/ocean ignoring\n!!"
fi

if [[ -f "$oldrom"_ocean.mk ]]; then
	mv "$oldrom"_ocean.mk "$newrom"_ocean.mk
	sed -i 's/'"$oldrom"'/'"$newrom"'/g' ./*.*
	cd ../../../
else
	printf "file not found please make sure your device tree is correct!\n"
	exit 1
fi

if [[ -d "device/motorola/sdm632-common" ]]; then 
	cd device/motorola/sdm632-common|| exit
else 
	printf "path to device doesn't exist"
	exit1
fi

if [[ -f "$oldrom.dependencies" ]]; then
	mv "$oldrom".dependencies "$newrom".dependencies || :
	sed -i 's/'"$oldrom"'/'"$newrom"'/g' ./*.*
	cd ../../../
else
	printf "There's no file .dependencies in /device/motorola/sdm632-common ignoring\n!!"
fi

printf "\n\n"
printf "your bring up is finished\n to start type\nsource build/envsetup.sh\n and lunch \n"
exit 1
