#!/bin/bash

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file will updated to be Monoline style"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
    sed -i -e 's/#555753/#797774/g' "$i" #dark grey
    sed -i -e 's/#808080/#797774/g' "$i" #grey
    sed -i -e 's/#2e3436/#3a3a38/g' "$i" #black
    sed -i -e 's/#888a85/#c8c6c4/g' "$i" #light gray
    sed -i -e 's/#c4cfe0/#c8c6c4/g' "$i" #border
    sed -i -e 's/#0968ef/#1e8bcd/g' "$i" #blue
    sed -i -e 's/#8f8f8f/#797774/g' "$i" #gray
    sed -i -e 's/#505050/#3a3a38/g' "$i" #black
    sed -i -e 's/#fff/#fafafa/g' "$i" #white
    #convert "$i" -quality 75 "$i"
done
