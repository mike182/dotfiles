#!/bin/bash

for file in dot.*; do
  name=${file/dot/}
  echo "Installing $name";
  ln -snf `pwd`/$file ~/$name
done

echo "Installing vim plugins"
vim -v -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa" # -v verbose check for errors
# vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
