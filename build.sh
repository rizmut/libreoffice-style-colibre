#!/bin/bash
#2020 by Rizal Muttaqin

links_light="colibre_svg/links.txt"
links_dark="colibre_dark_svg/links.txt"

if ! command -v optipng >/dev/null
then
    echo "Please install optipng"
    exit 1
fi

if ! command -v svgcleaner >/dev/null
then
    echo "Please install svgcleaner"
    exit 1
fi

echo "=> Remove old both light and dark version"

rm -Rf "colibre"
rm -Rf "colibre_dark"
rm -Rf "colibre_dark_svg"

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
cd "colibre"

echo "=> 1. colibre PNG (light) version"
echo "=> Export light SVG to PNG ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file is compressed"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	inkscape -f "$i" -e "${i%.*}.png"
	optipng -o7 "${i%.*}.png"
	#convert "$i" -quality 75 "$i"
done

echo "=> Delete light SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    fname=$( basename "$i")
    fdir=$( dirname "$i")
    rm "$i"
done

echo "=> 2. colibre SVG (dark) version"
cd "./.."

cp -Rf "colibre_svg" \
   "colibre_dark_svg"

cd "colibre_dark_svg"   

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
    echo "This $i file will be Dark Theme"
    fname=$( basename "$i")
#	echo "has the name: $fname"
    fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
    sed -i -e 's/#3a3a38/#3a3a37/g' "$i" #darkest grey to intermediary darkest grey
    sed -i -e 's/#fafafa/#3a3a38/g' "$i" #white to darkest grey
    sed -i -e 's/#3a3a37/#fafafa/g' "$i" #intermediary darkest grey to white
    sed -i -e 's/#797774/#797773/g' "$i" #dark gray to intermediary dark gray
    sed -i -e 's/#c8c6c4/#797774/g' "$i" #light gray to dark gray
    sed -i -e 's/#797773/#c8c6c4/g' "$i" #intermediary dark grey to light grey
    sed -i -e 's/#0063b1/#0063c1/g' "$i" #darkest blue to intermediary darkest blue
    sed -i -e 's/#83beec/#0063b1/g' "$i" #light blue to darkest blue
    sed -i -e 's/#0063c1/#83beec/g' "$i" #intermediary darkest blue to light blue
    sed -i -e 's/#922e9b/#922e8c/g' "$i" #darkest purple to intermediary darkest purple
    sed -i -e 's/#d492d8/#922e9b/g' "$i" #light purple to darkest purple
    sed -i -e 's/#922e8c/#d492d8/g' "$i" #intermediary darkest purple to light purple
    sed -i -e 's/#d42314/#d42313/g' "$i" #darkest red to intermediary darkest red
    sed -i -e 's/#ff9198/#d42314/g' "$i" #light red to darkest red
    sed -i -e 's/#d42313/#ff9198/g' "$i" #intermediary darkest red to light red
    sed -i -e 's/#309048/#309047/g' "$i" #darkest green to intermediary darkest green
    sed -i -e 's/#a1ddaa/#309048/g' "$i" #light green to darkest green
    sed -i -e 's/#309047/#a1ddaa/g' "$i" #intermediary darkest green to light green
    sed -i -e 's/#ed8733/#ed8732/g' "$i" #darkest orange to intermediary darkest orange
    sed -i -e 's/#f8db8f/#ed8733/g' "$i" #light orange to darkest orange
    sed -i -e 's/#ed8732/#f8db8f/g' "$i" #intermediary darkest orange to light orange
	#convert "$i" -quality 75 "$i"
done 

echo "=> 3. colibre PNG (dark) version"
cd "./.."

cp -Rf "colibre_dark_svg" \
   "colibre_dark"
cp "colibre/links.txt" \
   "colibre_dark"   
cd "colibre_dark" 

echo "=> Export dark SVG to PNG ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file is compressed"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	inkscape -f "$i" -e "${i%.*}.png"
	optipng -o7 "${i%.*}.png"
	#convert "$i" -quality 75 "$i"
done 

echo "=> Delete dark SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    fname=$( basename "$i")
    fdir=$( dirname "$i")
    rm "$i"
done

cd "./.."
echo "delete links.txt in SVG directories"

if [ -f $links_light ] ; then
    rm $links_light
fi

if [ -f $links_dark ] ; then
    rm $links_dark
fi
