" PATHOGENIC
call pathogen#runtime_append_all_bundles()


" window settings
set fileencoding=utf8
noremap <C-a> ^
noremap <C-e> $

ino jj <esc>
cno jj <c-c>

map tt <C-w>

" DISABLE ARROWS
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" make tab key more better
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" Peepopen remap
noremap <D-S-o> :PeepOpen
vnoremap <D-S-o> :PeepOpen
inoremap <D-S-o> :PeepOpen

" important settings
set incsearch
set ignorecase
set hlsearch

set nobackup
set nowritebackup
set noswapfile
set nofoldenable

" status line
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
        "set guifont=Monaco:h12.00
        set guifont=Menlo:h12.00
        set transparency=0
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
au BufNewFile, BufRead * :call HMBstart

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
" let g:molokai_original=1
colorscheme molokai "strawimodo railscasts xoria256  molokai, zenburn, darkburn, vibrantink
" change background

" PLUGINZ
" disable xrargs for grep.vim
let Grep_Find_Use_Xargs = 0
 " allml settings
let g:allml_global_maps = 1
let g:HiMtchBrktOn=1
let g:SCMDiffCommand="git"



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
" mappings:

noremap <F6> :NERDTreeToggle<CR>
inoremap <F6> <ESC>:call NERDTreeToggle()<CR>

noremap <F7> :CommandT<CR>
""""""""""" TOTALLY COOL FUNCTIONS"
command! GREP :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | copen
noremap <M-g> :GREP<CR>

function! s:ListRubyFunctions()
    lvimgrep /^\s*def/j %
    lopen
endfunction
command! -bar -narg=* ListDefs call s:ListRubyFunctions()

function! s:GotoRubyFunc()
    execute 'lvimgrep /def '.expand("<cword>").'/ **/*.rb'
endfunction
command! -bar -narg=* GotoDef call s:GotoRubyFunc()


" save all command under :W, possibly add new stuff to it
function! s:SaveAll()
    w | :Error
endfunction
command! -bar -narg=0 W call s:SaveAll()



" tabbing and retabbing function for ruby (or any lang that uses 2 spaces for
" indents), so that you can see indent levels specified using listchars"

set listchars=tab:\∣\ ,trail:-
function! s:ShowIndents()
  let curr = line(".")
  %s/  /\t/g
  execute "".curr
  set noexpandtab
endfunction
function! s:HideIndents()
  %s/\t/  /g
  set expandtab
  retab
endfunction


command! -bar -nargs=* IndSh call s:ShowIndents()
command! -bar -nargs=* IndH call s:HideIndents()


" CLEANUP EMPTY LINES WITH WHITESPACE
function! s:CleanUp()
  %s/^[\ \t]*\n//g
endfunction
command! -bar -nargs=* CleanEmptyLines call s:CleanUp()

function! s:CleanTrailing()
  %s/\s\+$//
endfunction
command! -bar -nargs=0 ClTrailing call s:CleanTrailing()


