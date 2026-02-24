#!/bin/bash
# Compile emacs from source
set -euo pipefail

RED='\033[0;31m'
NC='\033[0m' # No Color

EMACS_DIRECTORY="$HOME/tmp/emacs_permanent"
# EMACS_REPO="https://git.savannah.gnu.org/git/emacs.git"
EMACS_REPO="https://github.com/emacs-mirror/emacs"
STABLE_TAG="emacs-30.2"  # Change this to the desired stable tag

# Function to check if directory is a git repository
is_git_repo() {
    [ -d "$1/.git" ]
}

USE_STABLE=false
if [[ "${1:-}" == "--stable" ]]; then
    USE_STABLE=true
fi

echo "Target directory: $EMACS_DIRECTORY"
echo "Using stable version: $USE_STABLE"

# Check if target directory exists
if [ -d "$EMACS_DIRECTORY" ]; then
    echo "Directory exists: $EMACS_DIRECTORY"
    
    # Check if it's a git repository
    if is_git_repo "$EMACS_DIRECTORY"; then
        echo "Directory is a git repository. Pulling latest changes..."
        cd "$EMACS_DIRECTORY" || exit 1
        
        # Pull the latest changes
        git pull origin master
        if [ $? -ne 0 ]; then
            echo "Error: Failed to pull changes"
            exit 1
        fi
    else
        echo "Error: Directory exists but is not a git repository"
        echo "Please remove $EMACS_DIRECTORY or choose a different target directory"
        exit 1
    fi
else
    echo "Directory does not exist. Cloning repository..."
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$EMACS_DIRECTORY")"
    
    # Clone the repository
    git clone "$EMACS_REPO" "$EMACS_DIRECTORY"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository"
        exit 1
    fi
    
    cd "$EMACS_DIRECTORY" || exit 1
fi

# Switch to stable tag or stay on HEAD
if [ "$USE_STABLE" = true ]; then
    echo "Switching to stable tag: $STABLE_TAG"
    git checkout "$STABLE_TAG"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to checkout stable tag $STABLE_TAG"
        echo "Available tags:"
        git tag -l | grep "emacs-" | tail -10
        exit 1
    fi
    echo "Successfully switched to stable tag: $STABLE_TAG"
else
    echo "Staying on HEAD (latest development version)"
    git checkout master || echo "Warning: Failed to checkout master branch, staying on current branch"
fi

echo "Done! Emacs source code is ready in: $EMACS_DIRECTORY"
echo "Current branch/tag: $(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "detached HEAD")"


cd "$EMACS_DIRECTORY"

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

# compile everything, install emacs
./autogen.sh && ./configure --with-x-toolkit=lucid --with-mailutils --with-threads --with-native-compilation --with-tree-sitter --with-xml2 && make -j "$(nproc)" bootstrap && sudo make install && echo -e "${RED}emacs has been installed${NC}"

# Return the HEAD to the latest commit
if [ "$USE_STABLE" = true ]; then
  git checkout master
fi

# Get outside the directory
cd || exit 1

# # Remove the directory after all the actions
# # Check if the directory exists
# if [[ -d "$EMACS_DIRECTORY" ]]
# then
#   echo "$EMACS_DIRECTORY exists on your filesystem."
#   # delete the directory
#   rm -rf "$EMACS_DIRECTORY"
# fi

exit 0
