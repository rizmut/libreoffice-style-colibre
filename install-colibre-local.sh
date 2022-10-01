#!/bin/sh

set -e

gh_repo="libreoffice-style-colibre"
gh_desc="colibre LibreOffice icon themes"

cat <<- EOF

  $gh_desc
  https://github.com/rizmut/$gh_repo
  
  
EOF

temp_dir="$(mktemp -d)"

# Colibre
cd "colibre"
cp "links.txt" \
   "../colibre_dark"
zip -r -D images_colibre.zip *
mv "images_colibre.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file ..."
rm -f "Colibre-IconSet.oxt"
echo "=> Create new $gh_desc extension one ..."
cp "images_colibre.zip" \
   "Colibre-IconSet/iconsets"
cd "./Colibre-IconSet"
zip -r -D Colibre-IconSet.oxt *
mv "Colibre-IconSet.oxt" \
   "./.."
cd "./../.."

# Colibre Dark
cd "colibre_dark"
zip -r -D images_colibre_dark.zip *
mv "images_colibre_dark.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file (dark) ..."
rm -f "Colibre-Dark-IconSet.oxt"
echo "=> Create new $gh_desc extension one (dark) ..."
cp "images_colibre_dark.zip" \
   "Colibre-Dark-IconSet/iconsets"
cd "./Colibre-Dark-IconSet"
zip -r -D Colibre-Dark-IconSet.oxt *
mv "Colibre-Dark-IconSet.oxt" \
   "./.."
cd "./../.."

# colibre SVG
cd "colibre_svg"
zip -r -D images_colibre_svg.zip *
mv "images_colibre_svg.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file (SVG) ..."
rm -f "Colibre-SVG-IconSet.oxt"
echo "=> Create new $gh_desc extension one (SVG) ..."
cp "images_colibre_svg.zip" \
   "Colibre-SVG-IconSet/iconsets"
cd "./Colibre-SVG-IconSet"
zip -r -D Colibre-SVG-IconSet.oxt *
mv "Colibre-SVG-IconSet.oxt" \
   "./.."
cd "./../.."

# colibre Dark SVG
cd "colibre_dark_svg"
zip -r -D images_colibre_dark_svg.zip *
mv "images_colibre_dark_svg.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file (dark SVG) ..."
rm -f "Colibre-Dark-SVG-IconSet.oxt"
echo "=> Create new $gh_desc extension one (dark SVG) ..."
cp "images_colibre_dark_svg.zip" \
   "Colibre-Dark-SVG-IconSet/iconsets"
cd "./Colibre-Dark-SVG-IconSet"
zip -r -D Colibre-Dark-SVG-IconSet.oxt *
mv "Colibre-Dark-SVG-IconSet.oxt" \
   "./.."
cd "./../.."

echo "=> Deleting whole old $gh_desc ..."
sudo rm -f "/usr/share/libreoffice/share/config/images_colibre.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_colibre_dark.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_colibre_svg.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_colibre_dark_svg.zip"
echo "=> Installing ..."
sudo mkdir -p "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_colibre.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_colibre_dark.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_colibre_svg.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_colibre_dark_svg.zip" \
  "/usr/share/libreoffice/share/config"
for dir in \
  /usr/lib64/libreoffice/share/config \
  /usr/lib/libreoffice/share/config \
  /usr/local/lib/libreoffice/share/config \
  /opt/libreoffice*/share/config; do
  [ -d "$dir" ] || continue
  sudo ln -sf "/usr/share/libreoffice/share/config/images_colibre.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_colibre_dark.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_colibre_svg.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_colibre_dark_svg.zip" "$dir"
done
echo "=> Done!"
