" window settings
set lines=70
set columns=200
set fileencoding=utf8

set incsearch
set ignorecase
set hlsearch

" make the status line more useful
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set nocompatible

" backspace mode
set bs=2

" highlitt current line and add line numbers
set cursorline
set number

" yummy
set guifont=Monaco:h11.00

" turn off the scrollbars and the rest of the crap
set guioptions=eg
set transparency=9


""set foldenable
""set foldmethod=indent
filetype plugin on
filetype on

" autoindenting
set cindent
set smartindent
set autoindent

" display improvements
set list
" show indents
set listchars=tab:\.\ ,trail:-
set ruler
set showcmd
" i use tabs instead of spaces, wanna make something of it?
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" temp files
set backupdir=~/.vim/bak
set directory=~/.vim/tmp
" colorz
syntax on
colorscheme kellys " molokai, zenburn, darkburn, vibrantink

" PLUGINZ
 " allml settings
let g:allml_global_maps = 1
let g:HiMtchBrktOn=1
let g:SCMDiffCommand="/opt/subversion/bin/svn"

inoremap <C-B> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-B> :call PhpDocSingle()<CR>
vnoremap <C-B> :call PhpDocRange()<CR> 

" PHP specific fixes
" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query=1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings=1
" discourages use oh short tags. c'mon its deprecated remember
autocmd FileType php let php_noShortTags=1
" settings for cake
au BufNewFile  *.ctp set filetype=php
au BufRead *.ctp set filetype=php

