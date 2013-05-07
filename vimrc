"" Pathogen -----------------------------------------------------------------
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

runtime macros/matchit.vim

"" Global settings ----------------------------------------------------------
set fileencoding=utf8
set nocompatible
filetype plugin on
filetype indent on
filetype on
syntax on
set showbreak=$
set guioptions=eg
set title
if("&cm")
  set cm=blowfish "if X is used, make the encryption strong
endif

" visual clues for commands and navigation
set showcmd
set ruler
set scrolloff=3

" Wildmenu bro!
set wildmenu
set wildmode=list:longest,full

" search --------------------------------------------------------------------
set incsearch
set ignorecase smartcase
set hlsearch
:nnoremap <space> :nohlsearch<cr>


" No backups ----------------------------------------------------------------
" Vim crashes so rarely I don't feel like I need these
set nobackup
set nowritebackup
set noswapfile

" status line --------------------------------------------------------------
set statusline=
" file name
set statusline+=%f\ %2*%m\ %1*%h
" generic warning message
set statusline+=%#warningmsg#
" Syntastic status
set statusline+=%{SyntasticStatuslineFlag()}

" FuGITive status
set statusline+=%{fugitive#statusline()}
" span
"
set statusline+=%*
" [ encoding CR-type filetype]
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]

" current column line and total number of lines
set statusline+=\ %12.(%c:%l/%L%)

" always show status line
set laststatus=2


" backspace mode -----------------------------------------------------------
set bs=2

" lines and margins --------------------------------------------------------
" highlight current line and add line numbers
set cursorline

set number

" nice colors for error messages
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" right margin settings
if version > 702
  set colorcolumn=80
endif

" general text layout stuff ------------------------------------------------
" set line length for all files at 78
autocmd FileType text setlocal textwidth=78

" use spelling in email and git commit messages
autocmd FileType mail,gitcommit set spell


" colors -------------------------------------------------------------------
let &t_Co=256
set background=dark
colorscheme  grb256 "Tomorrow-Night
if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" indent --------------------------------------------------------------------
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" Key mappings -------------------------------------------------------------
" map C-h to ESC
noremap <C-h> <ESC>
inoremap <C-h> <ESC>

" make the command mode less annyoing
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-p> <Up>
cnoremap <c-n> <Down>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-d> <Del>

" open current file's location
nmap <leader>d :e %:h<CR>

nmap <leader>c :copen<cr>
nmap <leader>e :Errors<cr>
nmap <leader>C :cclose<cr>
" Better split management, kept in sync with tmux' mappings
" (<prefix>| and <prefix>-)

"split horizontally and switch to new split
noremap <leader>- :sp<CR><C-w>j
"split vertically and switch to new split
noremap <leader>\| :vsp<CR><C-w>l


" sudo write
map W w !sudo tee % >/dev/null

" disable arrows, commented out because I learned not to use them
" inoremap  <Down>   <NOP>
" inoremap  <Left>   <NOP>
" inoremap  <Right>  <NOP>
" inoremap  <Up>     <NOP>
" noremap   <Down>   <NOP>
" noremap   <Left>   <NOP>
" noremap   <Right>  <NOP>
" noremap   <Up>     <NOP>

" Borrowed from vimcasts, super useful----------------------------------------
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

" NETRW setttings ----------------------------------------------------------
let g:netrw_banner=0

" Programming language support and improvements -------------------------------
" Ruby  -----------------------------------------------------------------------
" non ruby files which are ruby
au BufNewFile,BufRead Capfile,Gemfile,Gemfile.lock,Guardfile,Rakefile,*.rake set filetype=ruby

" reject! and responds_to? are methods in ruby
autocmd FileType ruby setlocal iskeyword+=!,?,@

" Abbreviations aka snippets
autocmd Filetype ruby iabbr pry_ require 'pry'; binding.pry

" Ruby
autocmd Filetype ruby iabbr init- def initialize<CR>end<ESC>?initialize<ESC>$a
autocmd Filetype ruby iabbr cls class<CR>end<ESC>?class<ESC>$a
autocmd Filetype ruby iabbr mod module<CR>end<ESC>?module<ESC>$a
autocmd Filetype ruby iabbr d= def<CR>end<ESC>?def<ESC>$a
autocmd Filetype ruby iabbr d_ do<CR>end<ESC>O
autocmd Filetype ruby iabbr d- do \|\|<CR>end<ESC>k$i
autocmd Filetype ruby iabbr {- { \|A\| }<ESC>FA"_xi
autocmd Filetype ruby iabbr #- #{}<ESC>"_ci{
autocmd Filetype ruby iabbr rq- require ""<ESC>i

" ERB
autocmd Filetype eruby iabbr rt+ <% woo %><ESC>Fw<ESC>"_ciw
autocmd Filetype eruby iabbr rt- <%- woo  %><ESC>Fw<ESC>"_ciw
autocmd Filetype eruby iabbr rt= <%= woo  %><ESC>Fw<ESC>"_ciw
autocmd Filetype eruby iabbr rtc <%# woo  %><ESC>Fw<ESC>"_ciw

" Rspec yea
autocmd Filetype ruby iabbr dsc- describe  do<CR>end<ESC>?describe<ESC>wi
autocmd Filetype ruby iabbr it- it "" do<CR>end<ESC>?""<ESC>a
autocmd Filetype ruby iabbr cnt- context "" do<CR>end<ESC>?""<ESC>a
autocmd Filetype ruby iabbr sub- subject "" do<CR>end<ESC>?""<ESC>a
autocmd Filetype ruby iabbr lt- let : { }<ESC>?:<ESC>a

noremap <leader>R :! bundle exec rspec % -l

" make rspec stuff part of ruby syntax
autocmd BufNewFile,BufRead *_spec.rb syn keyword ruby describe
      \ context
      \ it
      \ specify
      \ it_should_behave_like
      \ before
      \ after
      \ setup
      \ subject
      \ its
      \ shared_examples_for
      \ shared_context
      \ let


" Javascript ----------------------------------------------------------------
" json & javascript
au BufNewFile,BufRead  *.json set ft=json
au BufNewFile,BufRead  *.js   set foldmethod=indent " Vim's JS support sux

" use conceal to hide 'function' keywoard and use cchar=λ as a replacement
au BufNewFile,BufRead *.js syntax keyword javaScriptFunction function conceal cchar=λ
au BufNewFile,BufRead *.js hi! link javaScriptFunction Conceal
au BufNewFile,BufRead *.js setlocal conceallevel=2

autocmd Filetype javascript iabbr f- function(){}<ESC>F{a
autocmd Filetype javascript iabbr cl- console.log('');<ESC>F'i

" other languages and such --------------------------------------------------

" mustache templates
au BufNewFile,BufRead  *.mustache set filetype=mustache

" markdown
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set filetype=markdown

" python is weird
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set listchars=tab:▸\ ,eol:~
au BufNewFile,BufRead *.py set list

" handlebars templates
au BufNewFile,BufRead *.hb set ft=handlebars

" yaml indent settings
au BufNewFile,BufRead  *.yml,*.yaml set foldmethod=indent
au BufNewFile,BufRead  *.yml,*.yaml set foldlevel=1

" tmux
au BufNewFile,BufRead *tmux.conf set syntax=tmux

" SCSS
autocmd FileType scss setlocal iskeyword+=-,$,@

" Scheme is a LISP, clojure as well
au BufNewFile,BufRead *.scm,*.clj set lisp

" Plugins settings ----------------------------------------------------------
" This work only if pathogen exists

" screen.vim
let g:ScreenImpl='Tmux'
noremap <leader>S :ScreenShell
vnoremap <leader>s :ScreenSend<CR>
noremap <leader>s :ScreenSend<CR>

" fugitive
function! GitBrowseIt(mode)
  let file = expand('%')
  if a:mode == 'l'
    let lineno = line('.')
    exec ":Git browse ".file." ".lineno

  elseif a:mode == 'v'
    let lineno = line("'<")
    let lastline = line("'>")
    exec ":Git browse ".file." ".lineno." ".lastline
  endif

endf

noremap <leader>B :call GitBrowseIt('o')<CR>
vnoremap <leader>B :call GitBrowseIt("v")<CR>

noremap <leader>g :Ggrep <cword><CR>

" syntastic
let g:syntastic_auto_loc_lis=1
let g:syntastic_enable_signs=1

" gist vim
let g:gist_show_privates=1
let g:gist_open_browser_after_post = 1
let g:gist_get_multiplefile = 1

" Tagbar and ctags
noremap <leader>t :TagbarToggle<CR>
set tags=./tags,tags,TAGS,ctags,./js.tags,./rb.tags,../project.tags
" /usr/local/bin/ctags


" Abbreviations  ------------------------------------------------------------
" 'cause snippets are overkill
iabbr me_ Łukasz
iabbr sig_ -- <CR>Łukasz<CR>http://coffeesounds.com
iabbr sigw_ -- <CR>Łukasz<CR>http://geckoboard.com

" Functions ----------------------------------------------------------------

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" quickly switch between absolute and relative line numbers
" "number" option was set at the beginning of the file

function! NumSwap()
  if &number
    set relativenumber
  else
    set number
  endif
endf

nmap <silent> <leader>l :call NumSwap()<cr>
vmap <silent> <leader>l :call NumSwap()<cr>gv

" wrap  a ruby block (identified by ruby-block in a begin-rescue-end
" and add pry to rescue block
" definitely it's not rock solid, since it's just a dump from a macro
function! WrapInPry()
  let @z="dObeginporescue => erequire 'pry' ; binding.pryend"
    :'<,'>normal @z
endf
vmap <leader>wr  :call WrapInPry()<CR>

function! ConvertHash()
  let @z="xf Pf=df "
  :normal @z
endf
nmap <leader>ch :call ConvertHash()<cr>
