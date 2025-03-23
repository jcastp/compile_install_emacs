#!/usr/bin/env sh
# Script to install all the dependencies for compiling emacs from source in Ubuntu
# plus other dependencies

# Install all the basic dependencies
sudo apt-get install -y git
sudo apt-get install -y build-essential
sudo apt-get build-dep emacs
sudo apt-get install -y autoconf

# libraries for more advanced emacs functions
sudo apt install -y libxml2-dev libjansson-dev libotf1 libotf-dev sqlite3 sqlite3-tools libsqlite3-dev libsqlite-0
sudo apt install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf libxaw7-dev libgnutls*-dev

# gcc-jit compile
sudo apt install -y libgccjit-14-dev libgccjit-13-dev libgccjit-12-dev libgccjit-11-dev

# install the needed tools for emacs
sudo apt install -y ripgrep pandoc git fd-find xclip scrot gnuplot shellcheck graphviz fd-find hunspell hunspell-es ffmpegthumbnailer mediainfo texinfo libtree-sitter-dev

# needed for the pdf-tools package
sudo apt install -y libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick

# python related packages needed
sudo apt install -y isort pipenv python3-nose python3-pytest python3-pylsp python3-pyflakes python3-flake8-black

# other packages
sudo apt install -y shfmt

# plantUML related install
sudo apt install -y plantuml

