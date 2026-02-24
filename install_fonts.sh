#!/usr/bin/env sh
set -e

INSTALL_DIR=/home/tmp
ETBEMBO_DIR="${ETBEMBO_DIR:-$HOME/Nextcloud/config/fonts/ET_Bembo}"

# Install the aporetic fonts (https://protesilaos.com/codelog/2025-02-04-aporetic-fonts-1-0-0/)
echo "Installing Aporetic fonts"
(git clone --depth 1 https://github.com/protesilaos/aporetic.git "$INSTALL_DIR/aporetic-fonts" || (cd "$INSTALL_DIR/aporetic-fonts/" && git pull)) && (cp "$INSTALL_DIR/aporetic-fonts"/*/TTF/*.ttf ~/.local/share/fonts/ && fc-cache -f)

# install fonts
sudo apt install -y font-manager
sudo apt install -y fonts-firacode

echo "Checking ETBembo font."
if fc-list | grep -qi "ETBembo"; then
  echo "ETBembo font already installed."
else
  echo "Installing ETBembo font."
  if [[ -d "$ETBEMBO_DIR" ]]; then
    cp "$ETBEMBO_DIR"/*.otf ~/.local/share/fonts/
    fc-cache -f
  else
    echo "ETBembo source directory not found: $ETBEMBO_DIR"
  fi
fi
