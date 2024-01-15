#!/bin/bash
# Compile emacs from source

RED='\033[0;31m'
NC='\033[0m' # No Color

# Directory to clone emacs to from git
EMACS_DIRECTORY='/home/jcastp/tmp/emacs'

# If we want to install a stable version
VERSION='emacs-29.1'

# install tree-sitter from source, as seen here: https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=feature/tree-sitter
# and load "sudo ldconfig"
# to load the modules, you will need to follow up the instructions there

# Check if the directory receiving the code exists
if [[ -d "$EMACS_DIRECTORY" ]]
then
  echo "$EMACS_DIRECTORY exists on your filesystem."
  # delete the directory
  rm -rf "$EMACS_DIRECTORY"
fi

# Clone the git repository
# With the "--stable" flag, we clone the stable version defined above
# Without it, we get the last commit
if [ $# -gt 0 ] && [ "$1" = "--stable" ]; then
  echo "${RED}Installing stable version of emacs${NC}"
  # check with the git protocol and, if it fails, go for the https
  git clone --depth 1 --branch ${VERSION} git://git.sv.gnu.org/emacs.git "$EMACS_DIRECTORY" || git clone --depth 1 --branch ${VERSION} https://git.savannah.gnu.org/git/emacs.git "$EMACS_DIRECTORY"
else
  # Without a version, just the latest commit
  echo "Installing HEAD version of emacs"
  git clone --depth 1 git://git.sv.gnu.org/emacs.git "$EMACS_DIRECTORY" || git clone --depth 1 https://git.savannah.gnu.org/git/emacs.git "$EMACS_DIRECTORY"
fi

cd "$EMACS_DIRECTORY"

# export CC="gcc-11"

# compile everything, install emacs
# Passing the CFLAGS to let the installer know where the libgccjit is located
# ./autogen.sh && ./configure --with-x-toolkit=lucid --with-mailutils --with-json --with-threads --with-native-compilation --with-tree-sitter=ifavailable --with-xml2 && make -j 4 bootstrap && sudo make install && echo -e "${RED}emacs has been installed${NC}"
./autogen.sh && ./configure --with-x-toolkit=lucid --with-mailutils --with-json --with-threads --with-native-compilation --with-tree-sitter --with-xml2 && make -j 4 bootstrap && sudo make install && echo -e "${RED}emacs has been installed${NC}"

# Get outside the directory
cd

# Remove the directory after all the actions
# Check if the directory exists
if [[ -d "$EMACS_DIRECTORY" ]]
then
  echo "$EMACS_DIRECTORY exists on your filesystem."
  # delete the directory
  rm -rf "$EMACS_DIRECTORY"
fi

exit 0
