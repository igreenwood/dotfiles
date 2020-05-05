#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew install wget
brew install git
brew install tree
brew install tig
brew install ag
brew install jq
brew install python3
# brew install neovim
brew install peco
brew install envchain
brew install tmux
brew install bat
brew install fd
brew install reattach-to-user-namespace
brew install ghq
brew install gpg
brew install mysql
brew install postgresql

# pip3 install neovim

ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/.zlogout $HOME/.zlogout
ln -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -snf $SCRIPT_DIR/.hyper.js $HOME/.hyper.js
ln -s $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -s $SCRIPT_DIR/.git_commit_message $HOME/.git_commit_message
git config --global commit.template $HOME/.git_commit_message
# ln -s $SCRIPT_DIR/nvim $HOME/.config/nvim
ln -s $SCRIPT_DIR/bin $HOME/bin
ln -s $SCRIPT_DIR/vscode/keybindings.json /Users/tsujidaisuke/Library/Application\ Support/Code/User/
ln -s $SCRIPT_DIR/vscode/settings.json /Users/tsujidaisuke/Library/Application\ Support/Code/User/
