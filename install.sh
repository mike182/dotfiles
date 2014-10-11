#!/bin/sh

echo "Cloning repos"
git submodule update --init --recursive

for file in dot.*; do
  name=${file/dot/}
  echo "Installing $name";
  ln -snf `pwd`/$file ~/$name
done

echo "Installing vim bundles"
vim +BundleInstall +qall
