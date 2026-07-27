#!/usr/bin/env sh
# Script to install all the dependencies for compiling emacs from source in Ubuntu
# plus other dependencies

set -e

# Installs only the packages from the given list that actually exist in apt's
# cache, so one unavailable package name (e.g. python3-nose on Debian) doesn't
# abort the whole script.
apt_install() {
    to_install=""
    for pkg in "$@"; do
        if apt-cache show "$pkg" 2>/dev/null | grep -q "^Package: "; then
            to_install="$to_install $pkg"
        else
            echo "Warning: package '$pkg' not found in apt, skipping" >&2
        fi
    done

    if [ -n "$to_install" ]; then
        # shellcheck disable=SC2086
        sudo apt-get install -y $to_install
    fi
}

# Install all the basic dependencies
apt_install git
apt_install build-essential
sudo apt-get build-dep -y emacs || echo "Warning: apt-get build-dep emacs failed, continuing" >&2
apt_install autoconf

# libraries for more advanced emacs functions
apt_install libxml2-dev libjansson-dev libotf1 libotf-dev sqlite3 sqlite3-tools libsqlite3-dev libsqlite3-0
apt_install build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf libxaw7-dev libgnutls*-dev

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
apt_install ripgrep pandoc git fd-find xclip scrot gnuplot shellcheck graphviz fd-find hunspell hunspell-en-us hunspell-es ffmpegthumbnailer mediainfo texinfo libtree-sitter-dev

# needed for the pdf-tools package
apt_install libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick

# python related packages needed
apt_install isort pipenv python3-nose python3-pytest python3-pylsp python3-pyflakes python3-flake8-black

# other packages
apt_install shfmt libenchant-2-dev pkgconf

# plantUML related install
apt_install plantuml
