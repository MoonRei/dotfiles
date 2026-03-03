#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "${DOTFILES_DIR}"

ln -sf "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

echo "Dotfiles installed."
