#!/usr/bin/env bash
echo Going home
cd ~

echo Cleaning up
echo Vim
rm -rf .vim
rm .vimrc

echo ZSH + Oh My ZSH!
rm -rf .oh-my-zsh
rm .zshrc

echo Cloning dotfiles and oh-my-zsh
git clone git@github.com:lukaszkorecki/DotFiles.git .vim > /dev/null
git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh > /dev/null

echo Symlinking .vimrc and .zshrc
ln -s ~/.vim/.vimrc .vimrc
ln -s ~/.vim/.zshrc .zshrc

echo Getting submodules for vim
cd .vim
git submodule init > /dev/null

git submodule update  > /dev/null

echo DONE
