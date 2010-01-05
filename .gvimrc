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
        set guifont=Consolas:h8
    endif
endif
" turn off the scrollbars and the rest of the crap
set guioptions=eg


set foldenable
set foldmethod=syntax
filetype plugin on
filetype on

" autoindenting
set cindent
set smartindent
set autoindent

" display improvements
set list
" show indents
set ruler
set showcmd
" i use tabs instead of spaces, wanna make something of it?
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" PHP FIX
au BufRead,BufNewFile *.php,*.ctp set shiftwidth=4 
au BufRead,BufNewFile *.php,*.ctp set tabstop=4 
au BufRead,BufNewFile *.php,*.ctp set softtabstop=4
au BufRead,BufNewFile *.php,*.ctp set noexpandtab
au BufRead,BufNewFile *.php,*.ctp set noexpandtab

set listchars=tab:\.\ ,trail:-
" temp files
if has('gui')
    if has('gui_win32')
    set backupdir=$HOME/.bak
    set directory=$HOME/.tmp
    else
    set backupdir=~/.bak
    set directory=~/.tmp
  endif
endif
" colorz
syntax on
colorscheme molokai "xoria256  molokai, zenburn, darkburn, vibrantink
" change background
let g:molokai_original=1


" PLUGINZ
 " allml settings
let g:allml_global_maps = 1
let g:HiMtchBrktOn=1
let g:SCMDiffCommand="/opt/subversion/bin/svn"

inoremap <C-B> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-B> :call PhpDocSingle()<CR>
vnoremap <C-B> :call PhpDocRange()<CR> 

au BufNewFile, BufRead * :call HMBstart

noremap <F6> :NERDTreeToggle<CR>
inoremap <F6> <ESC>:call NERDTreeToggle()<CR>

" PHP specific fixes
" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query=1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings=1
" discourages use oh short tags. c'mon its deprecated remember
autocmd FileType php let php_noShortTags=1
autocmd FileType php set makeprg=php\ -l\ %

" ruby"
autocmd FileType rb set makeprg=rb\ -wc\ %
let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"
" settings for cake
au BufNewFile  *.ctp set filetype=php
au BufRead *.ctp set filetype=php

au BufNewFile  *.md set filetype=mkd
au BufRead *.md set filetype=mkd
"
" set spellcheck for markdown files
au BufNewFile  *.md set spell
au BufRead *.md set spell

function! s:ListFunctions() " C style
    lvimgrep /function/j %
    lopen
endfunction
command! -bar -narg=0 LF call s:ListFunctions()


function! s:ListRubyFunctions() " Ruby style
    lvimgrep /def/j %
    lopen
endfunction
command! -bar -narg=0 LD call s:ListRubyFunctions()
function! s:ListJSFunctions() " js style
  lvimgrep /\w*:.*function.*{/ %
    lopen
endfunction
command! -bar -narg=0 JF call s:ListJSFunctions()

" save all command under :W, possibly add new stuff to it
function! s:SaveAll()
    w | make
endfunction
command! -bar -narg=0 W call s:SaveAll()


function! s:SuperSearch(filetype, what)
    let command = "lvimgrep /" . a:what . "/j **/*". a:filetype
    echo command
    execute command
    copen
endfunction
command! -bar -nargs=* SS call s:SuperSearch(<args>)
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" Open todo using taskpaper"
" TODO / FIXME add different taskapaper locations or/and different todo files
" (work/home/etc)"
function! s:OpenTodo()
   sp | e ~/Dropbox/todo.taskpaper
endfunction
command! -bar -nargs=* ToDo call s:OpenTodo()
