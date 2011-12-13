"" Pathogen -----------------------------------------------------------------
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"" Global settings ----------------------------------------------------------
set fileencoding=utf8
set nocompatible
filetype plugin on
filetype indent on
filetype on
syntax on
set showbreak=↪
set guioptions=eg

" search --------------------------------------------------------------------
set incsearch
set ignorecase
set hlsearch

" No backups ----------------------------------------------------------------
" Disable backup cuz I use that GIT fad
set nobackup
set nowritebackup
set noswapfile

" status line --------------------------------------------------------------
" XXX disabled because of statline plugin
" set statusline=
" set statusline+=%f\ %2*%m\ %1*%h
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%{fugitive#statusline()}
" set statusline+=%*
" set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)
set laststatus=2


" backspace mode -----------------------------------------------------------
set bs=2

" lines and margins --------------------------------------------------------
" highlight current line and add line numbers
set cursorline
set number

" right margin settings
if version > 702
  set colorcolumn=80
endif

" set line length for all files at 78
autocmd FileType text setlocal textwidth=78


" colors -------------------------------------------------------------------
set t_Co=256

let g:solarized_termcolors=256
set background=dark
colorscheme  molokai_mac


" indent --------------------------------------------------------------------
set ruler
set showcmd
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" Key mappings -------------------------------------------------------------
noremap <C-a> ^
noremap <C-e> $

noremap <leader>S /asdf<CR>
noremap <leader>- :sp<CR>
noremap <leader>\| :vsp<CR>

" sudo write
map w! w !sudo tee % >/dev/null

" better esc
ino jj <esc>
cno jj <c-c>

" better buffer/window/tab navigation
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
nmap <C-k> ddkP
nmap <C-j> ddp

" Bubble multiple lines
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" make tab key more better
noremap <tab> v>
noremap <s-tab> v<
vnoremap <tab> >gv
vnoremap <s-tab> <gv

"" Filetype specific --------------------------------------------------------
" python is weird

au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab

" qml
au BufNewFile,BufRead  *.qml set filetype=qml
" json as javascript
au BufNewFile,BufRead  *.json set filetype=javascript

" mustache templates
au BufNewFile,BufRead  *.mustache set filetype=mustache

" markdown
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set filetype=markdown
#au BufNewFile,BufRead  *.md,*.mkd,*.markdown set spell

" non ruby files which are ruby
au BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile set filetype=ruby

au BufNewFile,BufRead Rakefile set filetype=rake
au BufNewFile,BufRead Rakefile set syntax=ruby

au BufNewFile,BufRead *.rake set filetype=rake
au BufNewFile,BufRead *.rake set syntax=ruby

" tmux

au BufNewFile,BufRead *tmux.conf set syntax=tmux

" Clojure

let g:vimclojure#ParenRainbow=1



" Plugins settings ----------------------------------------------------------

" statline
let g:statline_fugitive = 1

" screen.vim
let g:ScreenImpl='Tmux'
noremap <leader>S :ScreenShell
vnoremap <leader>s :ScreenSend<CR>
noremap <leader>s :ScreenSend<CR>

" syntastic
let g:syntastic_auto_loc_lis=1
let g:syntastic_enable_signs=1

" indent guides
let g:indent_guides_auto_colors = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=black
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" gist vim
let g:gist_show_privates=1
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1

" disable xrargs for grep.vim
let Grep_Find_Use_Xargs = 0
noremap <Leader>r :Rfgrep<CR>

" Ack
noremap <Leader>a :Ack
if executable('ack-grep')
  let g:ackprg='ack-grep -H --nocolor --nogroup --column'
endif

" Tagbar
noremap <leader>o :TagbarToggle<CR>

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
  \ 'ctagsargs' : '--include-vars '
  \}
" Nerdtree

let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Functions ----------------------------------------------------------------

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
