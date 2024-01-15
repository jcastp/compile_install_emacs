# compile_install_emacs

My scripts to install and deploy emacs from its source.

## install_emacs_dependencies.sh
This script will install all the basic dependencies to compile emacs from source in an Ubuntu system (last tested in Ubuntu 22.04).
It also install some other packages for additional emacs features, and some fonts I use.

## compile_emacs.sh
This will compile emacs from source.
You need to change the directory where you want to store the temporary code and, perhaps, adjust the flags for compilation.
If everything goes right, you will end with the latest commit of emacs compiled.

## deploy_emacs_codeberg.sh
This will download my personal config from my codeberg.org repo.
Please, check the script, as it does some remote repo changes that probably won't work for you.