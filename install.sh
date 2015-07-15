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

mkdir -p $VIMDEPS_DIR

# ------------------------------------------
# Solarized color scheme:
# - install/update from $SOLARIZED_DIR

# clone/pull the repo
(
cd $VIMDEPS_DIR
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
# Powerline fonts
# - install/update from $POWERLINE_DIR

# clone/pull the repo
(
cd $VIMDEPS_DIR
if [ ! -d $POWERLINE_DIR ]; then
  echo "downloading powerline fonts..."
  git clone git@github.com:powerline/fonts.git $POWERLINE_DIR
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
echo "done!"

