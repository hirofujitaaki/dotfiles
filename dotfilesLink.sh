#!/bin/bash

# ln -s(n)f ~/dotfiles/original ~/.symbolic-file
# make original file here first then run sh, which creates the symbolic-file
ln -sf ~/dotfiles/.ctags ~/.ctags
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.inputrc ~/.inputrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -snf ~/dotfiles/.git_template ~/.git_template
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.tmux ~/.tmux
