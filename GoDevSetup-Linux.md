# Setting Up a Go Development Environment On Linux

These are the steps I use to set up a Linux system as a Go development environment.


# Packages

    sudo apt-get install python-dev cmake ncurses-dev git g++



# Compile vim

More details found here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

    mkdir -p ~/development && cd ~/development
    git clone https://github.com/vim/vim.git
    cd ~/development/vim
    ./configure --with-features=huge \
              --enable-multibyte \
              --enable-rubyinterp \
              --enable-pythoninterp \
              --with-python-config-dir=/usr/lib/python2.7/config \
              --enable-perlinterp \
              --enable-luainterp \
              --enable-gui=gtk2 --enable-cscope --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim74
    sudo make install


# Build Go from source

    cd ~
    wget https://storage.googleapis.com/golang/go1.4.2.src.tar.gz
    tar zxvf go1.4.2.src.tar.gz
    cd go/src
    ./all.bash


# Add the following to the bottom of ~/.profile

    export VISUAL=vim
    export EDITOR="$VISUAL"

    export GOROOT=${HOME}/go
    export PATH=${GOROOT}/bin:${PATH}

    export PATH_ORIG=$PATH
    alias go-here='export GOPATH=`pwd` && export PATH="${GOPATH}/bin:${PATH_ORIG}"'


# Update from ~/.profile

Either log out, then back in, or:

    source ~/.profile


# My vim setup

    mkdir -p ~/development && cd ~/development
    git clone https://github.com/wblakecaldwell/vim-setup.git
    cd ~/development/vim-setup && ./install.sh -f


# YouCompleteMe Plugin Setup

    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer --gocode-completer

