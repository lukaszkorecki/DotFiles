#!/usr/bin/env bash
echo Going home
cd ~

echo Cleaning up
echo \tVim
rm -rf .vim
rm .vimrc

echo \tZSH + Oh My ZSH!
rm -rf .oh-my-zsh
rm .zshrc

echo Cloning
git clone git@github.com:lukaszkorecki/DotFiles.git .vim
git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh

echo Symlinking .vimrc and .zshrc
ln -s ~/.vim/.vimrc .vimrc
ln -s ~/.vim/.zshrc .zshrc

echo Getting submodules
cd .vim
git submodule init

git submodule update

echo DONE
