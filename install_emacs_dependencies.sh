#!/usr/bin/env sh
# Script to install all the dependencies for compiling emacs from source in Ubuntu
# plus other dependencies

# Install all the basic dependencies
sudo apt-get install -y build-essential
sudo apt-get build-dep emacs
sudo apt-get install -y autoconf

# libraries for more advanced emacs functions
sudo apt install -y libxml2-dev libjansson-dev libotf1 libotf-dev libgccjit-12-dev libgccjit-11-dev sqlite3 sqlite3-tools
sudo apt install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf libxaw7-dev libgnutls*-dev

# install the needed tools for emacs
sudo apt install -y ripgrep pandoc git fd-find xclip scrot gnuplot shellcheck graphviz fd-find hunspell hunspell-es ffmpegthumbnailer mediainfo texinfo libtree-sitter-dev

# needed for the pdf-tools package
sudo apt install -y libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick

# python related packages needed
sudo apt install -y isort pipenv python3-nose python3-pytest python3-pylsp

# plantUML related install
sudo apt install -y plantuml

# install fonts
sudo apt install -y font-manager
sudo apt install -y fonts-firacode
echo "checking ETBembo font."
font-manager -l | grep "ETBembo" > /dev/null
if [[ $? -eq 0 ]]; then
  # If the pattern is found, execute this block
  echo "ETBembo font installed."
  # Add your commands or actions here
else
  # If the pattern is not found, execute this block
  echo "Installing ETBembo font."
  font-manager -i ~/Nextcloud/config/fonts/ET_Bembo/*.otf
  # Add your commands or actions here
fi

echo "checking JetBrains font."
font-manager -l | grep "JetBrains" > /dev/null
if [[ $? -eq 0 ]]; then
  # If the pattern is found, execute this block
  echo "JetBrains font installed."
  # Add your commands or actions here
else
  # If the pattern is not found, execute this block
  echo "Installing JetBrains font."
  font-manager -i ~/Nextcloud/config/fonts/JetBrainsMono/ttf/*.ttf
  # Add your commands or actions here
fi

# install Iosevka from a zip file
echo "checking Iosevka regular fonts."
font-manager -l |  grep -e "^Iosevka$" > /dev/null
if [[ $? -eq 0 ]]; then
  # If the pattern is found, execute this block
  echo "Iosevka fonts installed."
  # Add your commands or actions here
else
  # If the pattern is not found, execute this block
  echo "Installing Iosevka fonts."
  unzip -o ~/Nextcloud/config/fonts/super-ttc-iosevka-23.0.0.zip -d /tmp
  font-manager -i /tmp/iosevka.ttc 
  # install iosevka-comfy from a file
  font-manager -i ~/Nextcloud/config/fonts/iosevka*.ttf
  # Add your commands or actions here
fi

# install Iosevka-comfy from a zip file
echo "checking Iosevka Comfy font."
font-manager -l |  grep -e "Iosevka Comfy" > /dev/null
if [[ $? -eq 0 ]]; then
  # If the pattern is found, execute this block
  echo "Iosevka Comfy font installed."
  # Add your commands or actions here
else
  # If the pattern is not found, execute this block
  echo "Installing Iosevka Comfy font."
  # install iosevka-comfy from a file
  font-manager -i ~/Nextcloud/config/fonts/iosevka_comfy_ttf/*.ttf
  # Add your commands or actions here
fi
