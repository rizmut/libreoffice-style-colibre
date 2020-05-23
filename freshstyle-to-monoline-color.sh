#!/bin/bash

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file will updated to be Monoline style"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
    sed -i -e 's/#696969/#3a3a38/g' "$i" #dark grey
    sed -i -e 's/#808080/#797774/g' "$i" #grey
    sed -i -e 's/#39648f/#006381/g' "$i" #dark blue
    sed -i -e 's/#4d82b8/#1e8bcd/g' "$i" #blue
    sed -i -e 's/#eac282/#fb983b/g' "$i" #yellow
    sed -i -e 's/#dc526d/#d42314/g' "$i" #dark red
    sed -i -e 's/#e68497/#ed3d3b/g' "$i" #red
    sed -i -e 's/#76a797/#18ab50/g' "$i" #green
    sed -i -e 's/#588878/#309048/g' "$i" #dark green
    sed -i -e 's/#9868b9/#a846b2/g' "$i" #purple
    sed -i -e 's/#8959ab/#922e9b/g' "$i" #dark purple
   	#convert "$i" -quality 75 "$i"
done
