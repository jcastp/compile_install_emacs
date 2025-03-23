#!/bin/bash
# Compile emacs from source

RED='\033[0;31m'
NC='\033[0m' # No Color

# Directory to clone emacs to from git
EMACS_DIRECTORY='/home/tmp/emacs'

# If we want to install a stable version
VERSION='emacs-30.1'

# Check if the directory receiving the code exists
if [[ -d "$EMACS_DIRECTORY" ]]; then
  echo "$EMACS_DIRECTORY exists on your filesystem."
  echo "getting the diffs from upstream."
  cd "$EMACS_DIRECTORY" && git pull
else
  echo "cloning emacs source code"
  # test either git or http protocol
  git clone git://git.sv.gnu.org/emacs.git "$EMACS_DIRECTORY" || git clone https://git.savannah.gnu.org/git/emacs.git "$EMACS_DIRECTORY"
fi

# use the right gcc and library versions
gcc_versions=("14" "12" "11")
library_name="libgccjit"

# Initialize variables for storing the found GCC and library versions
latest_gcc_version=0
latest_library_version=0

for gcc_version in "${gcc_versions[@]}"; do
  # Check if gcc-${gcc_version} is available using apt
  if apt show gcc-"${gcc_version}" | grep -q "^Installed-Size: "; then
    # If found, extract the version number from the output of apt
    latest_gcc_version=$gcc_version
    if apt show libgccjit-"${gcc_version}"-dev | grep -q "^Installed-Size: "; then
      latest_library_version=$gcc_version
      break
    fi
  fi
done

# Print the found GCC and library versions
echo "Latest GCC version: ${latest_gcc_version}"
echo "Latest library (${library_name}) version: ${latest_library_version}"

# Passing the CFLAGS to let the installer know where the libgccjit is located
export CC="gcc-${latest_gcc_version}"


cd "$EMACS_DIRECTORY" || exit 1

# be sure to have the HEAD pointing to the latest commit.
git checkout master

# if option is "--stable" we point git to that tag
if [ $# -gt 0 ] && [ "$1" = "--stable" ]; then
  echo "${RED}Installing stable version of emacs${NC}"
  git checkout "${VERSION}"
fi

# compile everything, install emacs
./autogen.sh && ./configure --with-x-toolkit=lucid --with-mailutils --with-threads --with-native-compilation --with-tree-sitter --with-xml2 && make -j 4 bootstrap && sudo make install && echo -e "${RED}emacs has been installed${NC}"

# Return the HEAD to the latest commit
if [ $# -gt 0 ] && [ "$1" = "--stable" ]; then
  git checkout master
fi

# Get outside the directory
cd || exit 1

# Remove the directory after all the actions
# Check if the directory exists
# if [[ -d "$EMACS_DIRECTORY" ]]
# then
#   echo "$EMACS_DIRECTORY exists on your filesystem."
#   # delete the directory
#   rm -rf "$EMACS_DIRECTORY"
# fi

exit 0
