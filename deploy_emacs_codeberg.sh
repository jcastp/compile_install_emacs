#!/bin/bash
# deploy emacs config from codeberg.org

GIT_CONFIG_REPO='https://codeberg.org/jcastp/emacs.d.git'
# Local directory to deploy the config
# emacs first checks in ~/.emacs.d
EMACS_INSTALL_DIR='/home/jcastp/.emacs.d'

# # Check if the receiving config directory exists
# if [[ -d "$EMACS_INSTALL_DIR" ]]
# then
#   echo "$EMACS_INSTALL_DIR exists on your filesystem."
#   echo "Deleting $EMACS_INSTALL_DIR."
#   # delete the directory
#   rm -rf "$EMACS_INSTALL_DIR"
# fi

# Check if the receiving config directory exists
if [[ -d "$EMACS_INSTALL_DIR" ]]
then
  echo "$EMACS_INSTALL_DIR exists on your filesystem."
  
  # Generate timestamp in format YYYY-MM-DD_HH-MM-SS
  TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
  BACKUP_DIR="${EMACS_INSTALL_DIR}_backup_${TIMESTAMP}"
  
  echo "Renaming $EMACS_INSTALL_DIR to $BACKUP_DIR"
  
  # Rename the directory
  mv "$EMACS_INSTALL_DIR" "$BACKUP_DIR"
  
  if [ $? -eq 0 ]; then
    echo "Successfully renamed to $BACKUP_DIR"
  else
    echo "Error: Failed to rename directory"
    exit 1
  fi
fi

# Now we deploy the config
git clone $GIT_CONFIG_REPO $EMACS_INSTALL_DIR
# This code is to replace the remote for pushing
# We want to pull from codeberg without authentication, but push with it
# This is done with fetch in http, but push is ssh
cd  ${EMACS_INSTALL_DIR}
git remote set-url --push origin git@codeberg.org:jcastp/emacs.d.git
git remote -v

#################################
# start emacs to load the config
emacs --debug-init&

exit 0
