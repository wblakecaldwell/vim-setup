#!/bin/bash
# Vim Bootstrap
#
# Blake Caldwell <blakecaldwell@gmail.com>
# http://blakecaldwell.net
#

# base directory to hold our dependencies
VIMDEPS_DIR=~/vim-deps

# Where we store the Solarized repository
SOLARIZED_DIR="${VIMDEPS_DIR}/solarized"

# Where we store the Powerline Fonts repository
POWERLINE_DIR="${VIMDEPS_DIR}/powerline-fonts"

# Where we store the ctags repository
CTAGS_DIR="${VIMDEPS_DIR}/ctags"

# Where we store the themes for Terminal.app
TERMINAL_APP_THEME_DIR="${VIMDEPS_DIR}/terminal_app_theme"

mkdir -p $VIMDEPS_DIR
mkdir -p ~/.vim


# ------------------------------------------
# Install ~/.vimrc if it doesn't exist
if [ "$1" = "-f" ] || [ ! -f ~/.vimrc ]; then
  echo "updating ~/.vimrc"
  cp _vimrc ~/.vimrc
else
  echo "leaving your existing ~/.vimrc alone - run again with \"-f\" flag to overwrite"
fi

echo


# ------------------------------------------
# Solarized color scheme:
# - install/update from $SOLARIZED_DIR

# clone/pull the repo
(
if [ ! -d $SOLARIZED_DIR ]; then
  echo "downloading solarized..."
  git clone git://github.com/altercation/solarized.git $SOLARIZED_DIR
else
  echo "updating solarized..."
  cd $SOLARIZED_DIR && git pull origin master
fi
)

# symlink to where it belongs
if [ ! -L ~/.vim/colors ]; then
  ln -s "${SOLARIZED_DIR}/vim-colors-solarized/colors" ~/.vim/colors
fi

echo

# ------------------------------------------
# Solarized color pallet for OS X Terminal.app
(
if [[ `uname` == 'Darwin' ]]; then
  if [ ! -d $TERMINAL_APP_THEME_DIR ]; then
    echo "downloading pallete for OS X Terminal.app..."
    git clone https://github.com/tomislav/osx-terminal.app-colors-solarized $TERMINAL_APP_THEME_DIR
    open "${TERMINAL_APP_THEME_DIR}/Solarized Dark.terminal"
    open "${TERMINAL_APP_THEME_DIR}/Solarized Light.terminal"
  fi
fi
)

echo


# ------------------------------------------
# Powerline fonts
# - install/update from $POWERLINE_DIR

# clone/pull the repo
(
if [ ! -d $POWERLINE_DIR ]; then
  echo "downloading powerline fonts..."
  git clone https://github.com/powerline/fonts.git $POWERLINE_DIR
else
  echo "updating powerline fonts..."
  cd $POWERLINE_DIR && git pull origin master
fi
)

echo


# install - modified version of its install script (DTA)
(
echo "installing powerline fonts..."
cd $POWERLINE_DIR
find_command="find \"$POWERLINE_DIR\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"
if [[ `uname` == 'Darwin' ]]; then
  font_dir="$HOME/Library/Fonts"
else
  font_dir="$HOME/.fonts"
  mkdir -p $font_dir
fi
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"
if [[ -n `which fc-cache` ]]; then
  fc-cache -f $font_dir
fi
)

echo


# ------------------------------------------
# build/install ctags
(
if [[ `uname` == 'Darwin' ]]; then
  echo "downloading and installing ctags..."
  brew tap universal-ctags/universal-ctags
  brew install --HEAD universal-ctags
else
  if [ ! -f /usr/local/bin/ctags ]; then
    echo "ensuring dh-autoreconf is installed..."
    sudo apt-get install dh-autoreconf
    echo

    if [ ! -d $CTAGS_DIR ]; then
      echo "downloading ctags source..."
      git clone git@github.com:universal-ctags/ctags.git $CTAGS_DIR
    else
      echo "updating ctags source..."
      cd $CTAGS_DIR && git pull origin master
    fi

    echo "building and installing ctags..."
    cd $CTAGS_DIR
    autoreconf -vfi
    ./configure --prefix=/usr/local
    make
    sudo make install
  fi
fi
)

echo


# ------------------------------------------
# Vundle
(
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo "installing vundle"
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "updating vundle"
  cd ~/.vim/bundle/Vundle.vim && git pull origin master
fi
)
echo
echo "installing all plugins and Go binaries"
command -v mvim > /dev/null 2>&1
if [ $? -eq 0 ]; then
  # Mac
  mvim -v +PluginInstall +qall
  mvim -v +GoInstallBinaries +qall
  mvim -v +GoUpdateBinaries +qall
else
  # Linux - assume apt-get for now
  echo "Ensuring required system packages"
  dpkg -s python-dev cmake > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "System packages need to be installed - need sudo access:"
    sudo apt-get install python-dev cmake
  fi
  vim +PluginInstall +qall
  vim +GoInstallBinaries +qall
  vim +GoUpdateBinaries +qall
fi

echo
echo "done!"
echo

