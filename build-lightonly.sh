#!/bin/bash
#2020 by Rizal Muttaqin

# check if needed software is available to the system
prerequisites=true

if ! command -v optipng >/dev/null
then
    echo "Please install optipng"
    prerequisites=false
fi

if ! command -v svgcleaner >/dev/null
then
    echo "Please install svgcleaner"
    prerequisites=false
fi

if ! command -v inkscape >/dev/null
then
    echo "Please install inkscape"
    prerequisites=false
fi

# Exit if one or more packages are missing
if [[ $prerequisites == false ]]; then
  exit 1
fi


echo "=> Remove old PNG version"
cp "colibre/links.txt" \
   "colibre_svg"
rm -Rf "colibre"

cd "colibre_svg"

echo "=> Clean SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file is compressed"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	svgcleaner "$i" "${i%.*}.svg"
done

cd "./.."
cp -Rf "colibre_svg" \
   "colibre"
rm "colibre_svg/links.txt"
cd "colibre"

echo "=> Export SVG to PNG ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file is compressed"
	fname=$( basename "$i")
	fdir=$( dirname "$i")
	inkscape -f "$i" -e "${i%.*}.png"
	optipng -o7 "${i%.*}.png"
done

echo "=> Delete SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    fname=$( basename "$i")
    fdir=$( dirname "$i")
    rm "$i"
done
