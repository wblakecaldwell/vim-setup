"
" Original version from:  Jesse Nelson <spheromak@gmail.com>
" ab
"-------------------------------------------------------------------------------
"
"
set nocompatible               " be iMproved
scriptencoding utf-8
set encoding=utf-8


"set clipboard=unnamed

set ts=2
set sw=2
set expandtab
autocmd FileType go set tabstop=4|set shiftwidth=4|set noexpandtab

" buffer pos memory
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Scripts and Bundles " {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
Plugin 'godlygeek/tabular'
Plugin 'rodjek/vim-puppet'
Plugin 'kchmck/vim-coffee-script'
Plugin 'markcornick/vim-terraform'
Plugin 'Chiel92/vim-autoformat'
Plugin 'tpope/vim-fugitive'
Plugin 'oplatek/Conque-Shell'
Plugin 'rizzatti/dash.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'Townk/vim-autoclose'     	" interferes with YouCompleteMe
Plugin 'raimondi/delimitmate'		" replacement for Townk/vim-autoclose
Plugin 'airblade/vim-gitgutter'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 't9md/vim-chef'
Plugin 'JSON.vim'
Plugin 'ervandew/supertab'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
Plugin 'craigemery/vim-autotag'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/vim-json-bundle'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'

" Gist
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
" Track the engine.
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'
"
Plugin 'dgryski/vim-godef'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'kshenoy/vim-signature'

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
Plugin 'Valloric/YouCompleteMe'
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

call vundle#end()            " required
let g:Powerline_symbols = 'unicode'
filetype plugin indent on     " required!

" Common typos fixed.
"ab adn and

" ctrlp
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_regexp = 1

" search options
set ignorecase
set smartcase
set incsearch

" lines of visible b4 scroll
set scrolloff=10

" Date/Time stamps
" %a - Day of the week
" %b - Month
" %d - Day of the month
" %Y - Year
" %H - Hour
" %M - Minute
" %S - Seconds
" %Z - Time Zone

hi clear

set laststatus=2
set statusline=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=\ %{fugitive#statusline()}     " fugitive
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

"set grepprg=ack
"set grepformat=%f:%l:%m

" Don't use Ex mode, use Q for formatting
map Q gq

"highlight clear SignColumn

filetype plugin indent on
syntax on

let mapleader=','

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set cursorline     "highlight the current line
set hlsearch       "highlight all search results

"set paste
set number
"set mouse=a

filetype plugin on

highlight Pmenu ctermbg=238 gui=bold

"set guifont=Source\ Code\ Pro:h16 " Set default font
let g:SuperTabDefaultCompletionType = "context"

au FileType go map <leader>r :!go run %<CR>

let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }

" If you prefer the Omni-Completion tip window to close when a selection is
" " made, these lines close it on movement in insert mode or when leaving
" " insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" syntastic should populate the loclist
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

" jump loclist
map <Leader>n :lnext<CR>
map <Leader>p :lprev<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nmap <F8> :TagbarToggle<CR>
nmap <F1> :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

let g:NERDTreeWinSize = 50

"let g:godef_split=3
"
"faith-go
let g:go_auto_type_info = 1
let g:go_fmt_command = "gofmt"
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_bin_path = expand("~/go/bin")


"Run commands, such as go run with <leader>r for the current file or go build and go test for the current package with <leader>b and <leader>t. Display a beautiful annotated source code to see which functions are covered with <leader>c.
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>s <Plug>(go-implements)

"By default the mapping gd is enabled which opens the target identifier in current buffer. You can also open the definition/declaration in a new vertical, horizontal or tab for the word under your cursor:
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>df <Plug>(go-def)

au FileType go nmap <Leader>gr <Plug>(go-referrers)

"Open the relevant Godoc for the word under the cursor with <leader>gd or open it vertically with <leader>gv
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

"Or open the Godoc in browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

"Show type info for the word under your cursor with <leader>i (useful if you have disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>i <Plug>(go-info)

"Rename the identifier under the cursor to a new name
au FileType go nmap <Leader>e <Plug>(go-rename)

"More <Plug> mappings can be seen with :he go-mappings. Also these are just recommendations, you are free to create more advanced mappings or functions based on :he go-commands.

syntax enable
set background=dark
let g:solarized_termcolors=16
let g:solarized_visibility = "high"
let g:solarized_contrast = "normal"
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR> )
colorscheme solarized

nmap <silent> <F2> <Plug>DashSearch
nmap <silent> <F3> <Plug>DashSearch

" golint https://github.com/golang/lint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" AutoFormat on write
noremap <F3> :Autoformat<CR><CR>

" Set some nice character listings, then activate list
"execute 'set listchars+=tab:\ ' . nr2char(187)
"execute 'set listchars+=eol:' . nr2char(183)
"set list


setlocal spell spelllang=en_us
set spell

highlight ExtraWhitespace ctermbg=red guibg=red

" Removes trailing spaces on <Leader>rts and save
function! TrimWhiteSpace()
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfunction
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()
" end Removes trailing spaces

" reload when we save ~/.vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " } "} "

" C++ autocomplete via OmniCppComplete
command CppCtagsBuildDB execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
set nocp
