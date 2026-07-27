#!/bin/bash
# Install the fonts used by the emacs config
set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-$HOME/tmp}"
FONT_DIR="$HOME/.local/share/fonts"

# add the Hack font
sudo apt install -y fonts-hack

APORETIC_REPO=https://github.com/protesilaos/aporetic.git
# Fork of Edward Tufte's ET Book with OTF conversions and a fixed ligature table
ETBEMBO_REPO=https://github.com/DavidBarts/ET_Bembo.git

mkdir -p "$INSTALL_DIR" "$FONT_DIR"

# Clone the repo, or update it if it is already there
clone_or_update() {
  repo="$1"
  dest="$2"
  if [[ -d "$dest/.git" ]]; then
    git -C "$dest" pull --ff-only
  else
    git clone --depth 1 "$repo" "$dest"
  fi
}

# Install the aporetic fonts (https://protesilaos.com/codelog/2025-02-04-aporetic-fonts-1-0-0/)
echo "Installing Aporetic fonts"
clone_or_update "$APORETIC_REPO" "$INSTALL_DIR/aporetic-fonts"
cp "$INSTALL_DIR/aporetic-fonts"/*/TTF/*.ttf "$FONT_DIR/"

# install fonts
sudo apt install -y font-manager
sudo apt install -y fonts-firacode

echo "Checking ETBembo font."
if fc-list | grep -qi "ETBembo"; then
  echo "ETBembo font already installed."
else
  echo "Installing ETBembo font."
  clone_or_update "$ETBEMBO_REPO" "$INSTALL_DIR/et-bembo-fonts"
  cp "$INSTALL_DIR/et-bembo-fonts"/*.otf "$FONT_DIR/"
fi

fc-cache -f
