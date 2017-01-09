# Setting Up a Go Development Environment On Linux

These are the steps I use to set up a Linux system as a Go development environment.


# Packages

    sudo apt-get install python-dev cmake ncurses-dev git g++ libreadline-dev

# Compile & Install lua

    mkdir -p ~/development \
        && cd ~/development \
        && wget https://www.lua.org/ftp/lua-5.3.3.tar.gz \
        && tar zxvf lua-5.3.3.tar.gz \
        && cd lua-5.3.3 \
        && make linux \
        && sudo make install

# Compile vim

More details found here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

    export LUA_PREFIX=/usr/local
    mkdir -p ~/development \
        && cd ~/development \
        && git clone https://github.com/vim/vim.git \
        && cd ~/development/vim \
        && ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-gui=no \
            --enable-cscope \
            --without-x \
            --with-lua \
            --enable-luainterp \
            --with-features=huge \
            --prefix=/usr \
        && make VIMRUNTIMEDIR=/usr/share/vim/vim80 \
        && sudo make install
    
# Install ctags

    cd ~/development \
        && wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz \
        && tar zxvf ctags-5.8.tar.gz \
        && cd ~/development/ctags-5.8 \
        && ./configure \
        && make \
        && sudo make install


# Install Go 1.7

    cd ~ \
        && rm -rf ~/go \
        && wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz \
        && tar zxvf go1.7.linux-amd64.tar.gz


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

    mkdir -p ~/development && cd ~/development \
        && git clone https://github.com/wblakecaldwell/vim-setup.git \
        && cd ~/development/vim-setup && ./install.sh -f

