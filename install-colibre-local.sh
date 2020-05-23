#!/bin/sh

set -e

gh_repo="libreoffice-style-colibre"
gh_desc="colibre LibreOffice icon themes"

cat <<- EOF

  $gh_desc
  https://github.com/rizmut/$gh_repo
  
  
EOF

temp_dir="$(mktemp -d)"

cd "colibre"
zip -r -D images_colibre.zip *
mv "images_colibre.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file ..."
rm -f "Colibre-IconSet.oxt"
echo "=> Create new $gh_desc extension one ..."
cp "images_colibre.zip" \
   "Colibre-IconSet/iconsets/"
cd "./Colibre-IconSet"
zip -r -D Colibre-IconSet.oxt *
mv "Colibre-IconSet.oxt" \
   "./.."
cd "./../.."
cd "colibre_svg"
zip -r -D images_colibre_svg.zip *
mv "images_colibre_svg.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file ..."
rm -f "Colibre-SVG-IconSet.oxt"
echo "=> Create new $gh_desc extension one ..."
cp "images_colibre_svg.zip" \
   "Colibre-SVG-IconSet/iconsets/"
cd "./Colibre-SVG-IconSet"
zip -r -D Colibre-SVG-IconSet.oxt *
mv "Colibre-SVG-IconSet.oxt" \
   "./.."
   
cd "./../.."
echo "=> Deleting old $gh_desc ..."
sudo rm -f "/usr/share/libreoffice/share/config/images_colibre.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_colibre_svg.zip"
echo "=> Installing ..."
sudo mkdir -p "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_colibre.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_colibre_svg.zip" \
  "/usr/share/libreoffice/share/config"
for dir in \
  /usr/lib64/libreoffice/share/config \
  /usr/lib/libreoffice/share/config \
  /usr/local/lib/libreoffice/share/config \
  /opt/libreoffice*/share/config; do
  [ -d "$dir" ] || continue
  sudo ln -sf "/usr/share/libreoffice/share/config/images_colibre.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_colibre_svg.zip" "$dir"
done
echo "=> Done!"
