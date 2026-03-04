#!/bin/bash

set -e


ln -sf {`pwd`/,~/.}bashrc
ln -sf {`pwd`/,~/.}vimrc

# Set up the Qumulo toolchain and repos.
if [ ! -e ~/tools ]; then
    # apt runs during coder setup and conflicts with toolchain bootstrapping.
    sleep 60
    curl -s https://gravyweb.eng.qumulo.com/build/latest/src/build/toolchain/bootstrap.sh | bash
    ssh-keyscan -4 hg.eng.qumulo.com submit.eng.qumulo.com >> ~/.ssh/known_hosts
    ssh-keyscan -4 hg submit >> ~/.ssh/known_hosts
    hg clone --stream --config extensions.qumulo=! ssh://hg@hg.eng.qumulo.com/tools
    hg clone --stream --config extensions.qumulo=! ssh://hg@hg.eng.qumulo.com/src

    mv tools ~/tools
    mv src ~/src
fi

~/src/prebuild

echo "Dotfiles installed."
