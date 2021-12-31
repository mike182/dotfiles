dotfiles
========

vim/zsh/git

```bash
ln -snf ./dot.vimrc ~/.vimrc
ln -snf ./dot.zshrc ~/.zshrc
ln -snf ./dot.gitconfig ~/.gitconfig

vim -v -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
```
