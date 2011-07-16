#!/usr/bin/env bash
echo Going home
cd ~

echo Cleaning up
rm -rf .DotFiles
rm -rf .vim
rm .vimrc

rm -rf .oh-my-zsh
rm .zshrc

rm .gemrc

echo Cloning dotfiles and oh-my-zsh
git clone git@github.com:lukaszkorecki/DotFiles.git .DotFiles > /dev/null
git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh > /dev/null

echo Symlinking .vim and all rc files
ln -s ~/.DotFiles .vim
ln -s ~/.DotFiles/.vimrc .vimrc
ln -s ~/.DotFiles/.zshrc .zshrc
ln -s ~/.DotFiles/.gemrc .gemrc

echo Getting submodules for vim
cd .vim
git submodule init > /dev/null
git submodule update  > /dev/null

echo DONE
