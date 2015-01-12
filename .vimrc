" Plugins used: c.vim  neocomplcache.vim  python3.0.vim  python.vim  SearchComplete.vim  snipMate.vim  supertab.vim  surround.vim  taglist.vim  vimballPlugin.vim

set incsearch

set autoindent

set history=50

set ruler

set showmode
set showcmd

set ignorecase
set smartcase
set scrolloff=2
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set showmatch
set noerrorbells
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

map ,sh :source /home/jlcofell/.vim/vimsh/vimsh.vim

let g:vimsh_split_open=0
let g:vimsh_sh="/bin/bash"

let g:NeoComplCache_EnableAtStartup = 1
autocmd Filetype python set expandtab
autocmd Filetype python set softtabstop=4

:filetype plugin on
call pathogen#infect() 
