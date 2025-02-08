#!/usr/bin/env sh

# Install the iosevka comfy fonts
# (git clone --depth 1 https://github.com/protesilaos/iosevka-comfy.git /home/tmp/iosevka-comfy || (cd /home/tmp/iosevka-comfy/ && git pull)) && font-manager -i /home/tmp/iosevka-comfy/*/TTF/*.ttf
echo "Installing Iosevka-Comfy fonts"
(git clone --depth 1 https://github.com/protesilaos/iosevka-comfy.git /home/tmp/iosevka-comfy || (cd /home/tmp/iosevka-comfy/ && git pull)) && (cp /home/tmp/iosevka-comfy/*/TTF/*.ttf ~/.local/share/fonts/ && fc-cache -f)

# Install the aporetic fonts (https://protesilaos.com/codelog/2025-02-04-aporetic-fonts-1-0-0/)
echo "Installing Aporetic fonts"
(git clone --depth 1 https://github.com/protesilaos/aporetic.git /home/tmp/aporetic-fonts || (cd /home/tmp/aporetic-fonts/ && git pull)) && (cp /home/tmp/aporetic-fonts/*/TTF/*.ttf ~/.local/share/fonts/ && fc-cache -f)

# Install the lexend fonts
echo "Installing Lexend fonts"
# (git clone https://github.com/googlefonts/lexend /home/tmp/lexend/ || (cd /home/tmp/lexend/ && git pull)) && font-manager -i /home/tmp/lexend/fonts/lexend/ttf/*.ttf
(git clone https://github.com/googlefonts/lexend /home/tmp/lexend/ || (cd /home/tmp/lexend/ && git pull)) && (cp /home/tmp/lexend/fonts/lexend/ttf/*.ttf ~/.local/share/fonts/ && fc-cache -f)
echo "Installing Lexend Italic fonts"
# (git clone https://github.com/richardhriech/LexendItalic /home/tmp/lexend_italic/ || (cd /home/tmp/lexend_italic/ && git pull)) && font-manager -i /home/tmp/lexend_italic/*.ttf
(git clone https://github.com/richardhriech/LexendItalic /home/tmp/lexend_italic/ || (cd /home/tmp/lexend_italic/ && git pull)) && (cp /home/tmp/lexend_italic/*.ttf ~/.local/share/fonts/ && fc-cache -f)
