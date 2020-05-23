#!/bin/bash

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file will updated to be Monoline style"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
    sed -i -e 's/#797774/#3a3a38/g' "$i" #dark grey
    sed -i -e 's/#ffffff/#fafafa/g' "$i" #grey
    #convert "$i" -quality 75 "$i"
done
