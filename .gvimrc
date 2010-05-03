" window settings
set fileencoding=utf8

set incsearch
set ignorecase
set hlsearch

set statusline=
set statusline+=%f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)
set laststatus=2
set nocompatible

" backspace mode
set bs=2

" highlitt current line and add line numbers
set cursorline
set number

" yummy
set antialias
if has('gui')
    if has('gui_gnome')
        set guifont=DejaVu\ Sans\ Mono\ 8
    elseif has('gui_macvim')
        set guifont=Monaco:h11.00
        set transparency=2
    elseif has('gui_win32')
        set guifont=Consolas:h8
    endif
endif
" turn off the scrollbars and the rest of the crap
set guioptions=eg


""set foldmethod=syntax
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

set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

au BufNewFile, BufNewFile * HMBstart

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
let g:molokai_original=1
colorscheme molokai "xoria256  molokai, zenburn, darkburn, vibrantink
" change background


" PLUGINZ
 " allml settings
let g:allml_global_maps = 1
let g:HiMtchBrktOn=1
let g:SCMDiffCommand="git"


au BufNewFile, BufRead * :call HMBstart

noremap <F6> :NERDTreeToggle<CR>
inoremap <F6> <ESC>:call NERDTreeToggle()<CR>

let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"

""""""""" "MARKDOWN
au BufNewFile  *.md set filetype=mkd
au BufRead *.md set filetype=mkd
au BufNewFile  *.markdown set filetype=mkd
au BufRead *.markdown set filetype=mkd
"
" set spellcheck for markdown files
au BufNewFile  *.md set spell
au BufRead *.md set spell
au BufNewFile  *.markdown set spell
au BufRead *.markdown set spell
"
""""""""""" TOTALLY COOL FUNCTIONS"
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
    lvimgrepa /^\sfunction/j %
    lopen
endfunction
command! -bar -narg=0 JF call s:ListJSFunctions()

" save all command under :W, possibly add new stuff to it
function! s:SaveAll()
    w | :Error
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
cmap w!! %!sudo tee > /dev/null %


function! g:CleanUp()
  %s/^[\ \t]*\n//g
endfunction
" folding"
set foldmethod=marker
set foldmarker={,}
set nobackup
set nowritebackup
set noswapfile
set nofoldenable
