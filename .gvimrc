" PATHOGENIC
call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" window settings
set fileencoding=utf8
filetype plugin on
filetype indent on
filetype on



" important settings
set incsearch
set ignorecase
set hlsearch

" Disable backup cuz I use that GIT fad
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

" colorz
syntax on
" let g:molokai_original=1
colorscheme molokai "strawimodo railscasts xoria256  molokai, zenburn, darkburn, vibrantink


" display improvements
set list
set lcs=tab:>-,trail:-

" show indents
set ruler
set showcmd
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab


" nice mappings
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


" change background

" PLUGINZ
" disable xrargs for grep.vim
let Grep_Find_Use_Xargs = 0


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
command! GREP :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | copen
noremap <M-g> :GREP<CR>

noremap <Leader>n :NERDTreeToggle<CR>

""""""""""" TOTALLY COOL FUNCTIONS"

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

function! s:CleanTrailing()
  %s/\s\+$//
endfunction
command! -bar -nargs=0 ClTrailing call s:CleanTrailing()

" tags:
set tags=./tags
