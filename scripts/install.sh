#!/usr/bin/env zsh

VIMRC=~/.vimrc

# ctags 
if [[ $(uname) == "Darwin" ]]; then
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags
else
  sudo apt install universal-ctags
fi


echo "Linking .vimrc..."
if [ -L $VIMRC ]; then
  echo "  .vimrc already linked"
else
  echo "  .vimrc does not exist. Linking..."
  ln -s ~/dotfiles/vimrc ~/.vimrc
fi

echo "Installing vim-plug..."
if [ -e ~/.vim/autoload/plug.vim ]; then
  echo "  vim-plug already installed"
else
  echo "  installing vim-plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# global gems
if type "gem" > /dev/null; then
  # install foobar here
  gem install gem-ctags
fi

# rbenv + ruby std lib ctags
# TODO: install rbenv
# mkdir -p ~/.rbenv/plugins
# git clone https://github.com/tpope/rbenv-ctags.git \
#   ~/.rbenv/plugins/rbenv-ctags
# rbenv ctags

echo "DONE!!"
