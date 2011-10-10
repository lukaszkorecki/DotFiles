"" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"" Global settings
set fileencoding=utf8
filetype plugin on
filetype indent on
filetype on


" set line length for all files at 78
autocmd FileType text setlocal textwidth=78

" important settings
set incsearch
set ignorecase
set hlsearch

" Disable backup cuz I use that GIT fad
set nobackup
set nowritebackup
set noswapfile

" status line
set statusline=
set statusline+=%f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{fugitive#statusline()}
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)
set laststatus=2

set nocompatible

" backspace mode
set bs=2

" highlitt current line and add line numbers
set cursorline
if version > 702
  set colorcolumn=80
endif
set number
set showbreak=↪

set guioptions=eg
syntax on

" yummy
set antialias
if has('gui')
    if has('gui_gnome')
        set guifont=DejaVu\ Sans\ Mono\ 8
    elseif has('gui_macvim')
        set guifont=Menlo:h12.00
        set transparency=0
    elseif has('gui_win32')
        set guifont=Consolas:h8
    endif
endif

" turn off the scrollbars and the rest of the crap

if ! has('gui')
  set t_Co=256
endif

" colorz
set background=dark
let g:solarized_contrast='high'
colorscheme  molokai_mac "Tomorrow-Night


" indent settings
set ruler
set showcmd
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" nice mappings
noremap <C-a> ^
noremap <C-e> $

noremap <C-P> :tabp<CR>
noremap <C-N> :tabn<CR>

noremap <leader>S /asdf<CR>
noremap <leader>- :sp<CR>
noremap <leader>\| :vsp<CR>
" sudo write
map w! w !sudo tee % >/dev/null

" better esc
ino jj <esc>
cno jj <c-c>

" better buffer/window/tab navigation
map ee <C-w>
nnoremap <D-d> <C-w>v<C-w>l
nnoremap <D-D> <C-w>s<C-w>j

" disable arrows
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
noremap <tab> v>
noremap <s-tab> v<
vnoremap <tab> >gv
vnoremap <s-tab> <gv

"" Filetype specific settings

" qml
au BufNewFile,BufRead  *.qml set filetype=qml
" json as javascript
au BufNewFile,BufRead  *.json set filetype=javascript

" mustache templates
au BufNewFile,BufRead  *.mustache set filetype=mustache

" markdown filetype
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set filetype=markdown
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set spell

" non ruby files
au BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile set filetype=ruby

au BufNewFile,BufRead Rakefile set filetype=rake
au BufNewFile,BufRead Rakefile set syntax=ruby

au BufNewFile,BufRead *.rake set filetype=rake
au BufNewFile,BufRead *.rake set syntax=ruby


au BufNewFile,BufRead *tmux.conf set syntax=tmux
" Clojure

let g:vimclojure#ParenRainbow=1

" Python specific settings
let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab


"" Plugin settings

let  twitvim_browser_cmd="open"
let twitvim_count = 50
let g:PreviewBrowsers='qlmanage -p'
:nmap <Leader>v :Preview<CR>

" syntastic
let g:syntastic_auto_loc_lis=1
let g:syntastic_enable_signs=1
" indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" gist vim
let g:gist_show_privates=1
let g:gist_clip_command = 'pbcopy'

" disable xrargs for grep.vim
let Grep_Find_Use_Xargs = 0
noremap <Leader>r :Rfgrep<CR>

" Ack
noremap <Leader>a :Ack
" command t
noremap <Leader>p :CommandT<CR>
noremap <Leader>l :CommandTBuffer<CR>

" Tagbar
noremap <leader>o :TagbarToggle<CR>

let g:tagbar_left=1
set tags=tags,.git/tags,TAGS

 let g:tagbar_type_coffee = {
  \ 'kinds' : [
  \   'f:functions',
  \   'o:object'
  \ ],
  \ 'kind2scope' : {
  \  'f' : 'object',
  \   'o' : 'object'
  \},
  \ 'sro' : ".",
  \ 'ctagsbin' : 'coffeetags',
  \}
" Nerdtree
noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

"" Functions

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
