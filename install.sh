#!/bin/bash

set -e


ln -sf {`pwd`/,~/.}bashrc
ln -sf {`pwd`/,~/.}vimrc
ln -sf {`pwd`/,~/.}hgrc

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

# Set up Vim LSP: vim-lsp plugins (native packages) + the `nil` Nix language server.
VIM_PACK=~/.vim/pack/lsp/start
mkdir -p "$VIM_PACK"
for repo in \
    prabirshrestha/vim-lsp \
    mattn/vim-lsp-settings \
    prabirshrestha/asyncomplete.vim \
    prabirshrestha/asyncomplete-lsp.vim \
    LnL7/vim-nix; do
    dest="$VIM_PACK/$(basename "$repo")"
    if [ ! -e "$dest" ]; then
        git clone --depth=1 "https://github.com/$repo.git" "$dest"
    fi
done

if ! command -v nil >/dev/null 2>&1; then
    nix profile install github:oxalica/nil
fi

echo "Dotfiles installed."
