# vim-setup

I'm a total vim newb, working on my .vimrc.

Thanks to Jesse Nelson for getting me started: https://github.com/spheromak

Dependencies
------------

I put all my vim dependencies in ~/vim-deps, running `./install.sh` to install/update everything.

The script will only write to ~/.vimrc if it doesn't exist.

### Vim 7.4+

#### Linux

http://www.vim.org/

Install with:

    apt-get install vim

#### Mac (MacVim)

https://github.com/macvim-dev/macvim

Installing:

    $ cd src
    $ ./configure --with-features=huge \
                  --enable-rubyinterp \
                  --enable-pythoninterp \
                  --enable-perlinterp \
                  --enable-cscope
    $ make
    $ sudo mv MacVim/build/Release/MacVim.app /Applications/MacVim.app
    $ mkdir -p ~/bin
    $ ln -s `pwd`/src/MacVim/mvim ~/bin/mvim

Making sure your PATH is set up properly and "vim" is aliased to mvim (~/.bash_profile)

    export PATH=~/bin:$PATH
    alias vim='mvim -v'
    alias vi='mvim -v'


### Others (Lots!)

Everything else is installed with:

    ./install.sh
