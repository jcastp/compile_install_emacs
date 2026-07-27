#!/usr/bin/env sh
# Script to install all the dependencies for compiling emacs from source in Ubuntu
# plus other dependencies

set -e

# Install all the basic dependencies
sudo apt-get install -y git
sudo apt-get install -y build-essential
sudo apt-get build-dep emacs
sudo apt-get install -y autoconf

# libraries for more advanced emacs functions
sudo apt-get install -y libxml2-dev libjansson-dev libotf1 libotf-dev sqlite3 sqlite3-tools libsqlite3-dev libsqlite3-0
sudo apt-get install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf libxaw7-dev libgnutls*-dev

# gcc-jit compile: install whichever version is available in this distro's repos
gccjit_found=""
for v in 15 14 13 12 11; do
    if apt-cache show "libgccjit-${v}-dev" 2>/dev/null | grep -q "^Package: "; then
        gccjit_found="$v"
        break
    fi
done

if [ -z "$gccjit_found" ]; then
    echo "Error: none of libgccjit-{15,14,13,12,11}-dev is available in apt" >&2
    exit 1
fi

echo "Installing libgccjit-${gccjit_found}-dev"
sudo apt-get install -y "libgccjit-${gccjit_found}-dev"

# install the needed tools for emacs
sudo apt-get install -y ripgrep pandoc git fd-find xclip scrot gnuplot shellcheck graphviz fd-find hunspell hunspell-en-us hunspell-es ffmpegthumbnailer mediainfo texinfo libtree-sitter-dev

# needed for the pdf-tools package
sudo apt-get install -y libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick

# python related packages needed
sudo apt-get install -y isort pipenv python3-nose python3-pytest python3-pylsp python3-pyflakes python3-flake8-black

# other packages
sudo apt-get install -y shfmt libenchant-2-dev pkgconf

# plantUML related install
sudo apt-get install -y plantuml
