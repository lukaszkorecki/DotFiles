" window settings
set fileencoding=utf8

set incsearch
set ignorecase
set hlsearch

" make the status line more useful
""set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set statusline=%f\ %2*%m\ %1*%h%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}\ %{getfperm(@%)}]\ 0x%B\ %12.(%c:%l/%L%)
set laststatus=2

set nocompatible

" backspace mode
set bs=2

" highlitt current line and add line numbers
set cursorline
set number

" yummy
if has('gui')
	if has('gui_gnome')
		set guifont=DejaVu\ Sans\ Mono\ 8
	elseif has('gui_macvim')
		set guifont=Monaco:h12.00
		"set transparency=9
	elseif has('gui_win32')
		set guifont=Monaco:h8
	endif
endif
" turn off the scrollbars and the rest of the crap
set guioptions=eg


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
set backupdir=~/.bak
set directory=~/.tmp
" colorz
syntax on
colorscheme herald "xoria256  molokai, zenburn, darkburn, vibrantink


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
autocmd FileType php set makeprg=php\ -l\ %
" settings for cake
au BufNewFile  *.ctp set filetype=php
au BufRead *.ctp set filetype=php

" Maximize your (g|mac)vim window
" Put this in your .(g)vimrc
" :w | so %
" :WinMax (can be whatever you like) - just change the alias in the last line (own functions need to start with capital letter)
function! s:MAX()
	set lines=999
	set columns=999
endfunction

command! -bar -narg=0 WinMax call s:MAX()


function! s:ListFunctions()
	vimgrep /function/j %
	copen
endfunction
command! -bar -narg=0 LS call s:ListFunctions()

" save all command under :W, possibly add new stuff to it
function! s:SaveAll()
	wall
endfunction
command! -bar -narg=0 W call s:SaveAll()


function! s:SuperSearch(filetype, what)
	let command = "vimgrep /" . a:what . "/j **/*". a:filetype
	echo command
	execute command
	copen
endfunction
command! -bar -nargs=* SS call s:SuperSearch(<args>)
