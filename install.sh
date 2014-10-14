#!/bin/bash

for file in dot.*; do
  name=${file/dot/}
  echo "Installing $name";
  ln -snf `pwd`/$file ~/$name
done

echo "Installing vim bundles"
vim +PluginInstall +qall
