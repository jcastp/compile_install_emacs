#!/usr/bin/env sh

# Install the aporetic fonts (https://protesilaos.com/codelog/2025-02-04-aporetic-fonts-1-0-0/)
echo "Installing Aporetic fonts"
(git clone --depth 1 https://github.com/protesilaos/aporetic.git /home/tmp/aporetic-fonts || (cd /home/tmp/aporetic-fonts/ && git pull)) && (cp /home/tmp/aporetic-fonts/*/TTF/*.ttf ~/.local/share/fonts/ && fc-cache -f)

# install fonts
sudo apt install -y font-manager
sudo apt install -y fonts-firacode

echo "checking ETBembo font."
font-manager -l | grep "ETBembo" >/dev/null
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
