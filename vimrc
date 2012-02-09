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

" Folding ------------------------------------------------------------------
set foldmethod=syntax
set foldcolumn=1
set foldlevel=2
let g:f__olded = 0

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
set background=dark
let &t_Co=256
let g:solarized_termtrans  = 0
let g:solarized_termcolors = 256
colorscheme Monokai
" XXX use these only if solarized dark is used!
hi Normal  ctermbg=NONE cterm=NONE
hi Number  ctermbg=NONE cterm=NONE
hi LineNr  ctermfg=darkgray    ctermbg=NONE        cterm=NONE


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
noremap <leader>- :sp<CR><C-w>j
noremap <leader>\| :vsp<CR><C-w>l

" sudo write
map w! w !sudo tee % >/dev/null

" better esc
inoremap jj <esc>l
cnoremap jj <c-c>l

" tabs
map <leader>P :tabprevious<CR>
map <leader>N :tabnext<CR>

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

" ... and so is puppet
au BufNewFile,BufRead *.pp set tabstop=4
au BufNewFile,BufRead *.pp set softtabstop=4
au BufNewFile,BufRead *.pp set shiftwidth=4
au BufNewFile,BufRead *.pp set expandtab

" qml
au BufNewFile,BufRead  *.qml set filetype=qml

" json as javascript
au BufNewFile,BufRead  *.json set syntax=javascript

" mustache templates
au BufNewFile,BufRead  *.mustache set filetype=mustache

" markdown
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set filetype=markdown

" non ruby files which are ruby
au BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile,Rakefile,*.rake set filetype=ruby

" reject! and responds_to? are methods in ruby
autocmd FileType ruby setlocal iskeyword+=!,?,@
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" tmux

au BufNewFile,BufRead *tmux.conf set syntax=tmux

" Clojure

let g:vimclojure#ParenRainbow=1



" Plugins settings ----------------------------------------------------------
" TwitVim
let twitvim_count = 50
let twitvim_browser_cmd = 'open'
let twitvim_show_header = 0
let twitvim_filter_enable = 1
let twitvim_filter_regex = '@GetGlue\|/youtu\.be/'

" snipmate
let g:snippets_dir = "~/.vim/snippets/"
" statline
let g:statline_fugitive = 1
let g:statline_filename_relative = 1
let g:statline_show_charcode = 1

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
noremap <Leader>a :Ack <cword><cr>
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

" add a definition for Objective-C to tagbar
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

" Nerdtree

let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>D :NERDTreeFind<cr>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

let NERDTreeWinPos='right'

" CtrlP

set wildignore +=*/.sass-cache/* ",*/release/*



" Lang specific abbreviations ('cause snippets are overkill) --------------
iabbr me_ Łukasz
iabbr sig_ -- <CR>Łukasz

iabbr pry_ require 'pry'; binding.pry

" Ruby
autocmd Filetype ruby iabbrev cls class<CR>end<ESC>?class<ESC>$a
autocmd Filetype ruby iabbr d= def<CR>end<ESC>?def<ESC>$a
autocmd Filetype ruby iabbr d_ do<CR>end<ESC>O
autocmd Filetype ruby iabbr d- do \|ppp\|<CR>end<ESC>?ppp<ESC>diw


" Javascript
autocmd Filetype javascript iabbr f_ function(){<CR>}<ESC>?{<ESC>o
autocmd Filetype javascript iabbr f- function(){}<ESC>?{<ESC>a


" Functions ----------------------------------------------------------------

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

fun! ToggleFolds()
  if g:f__olded == 0
    let g:f__olded = 1
    set foldlevel=9999
  else
    let g:f__olded = 0
    set foldlevel=2
  endif
endfun
noremap <leader>f :call ToggleFolds()<CR>
vnoremap <leader>f :call ToggleFolds()<CR>

fun! PastedFromTmux()
  %s/\\015/\r/g
  /asdf
endfun

command!  -nargs=0 FromTmux call PastedFromTmux(<args>)

" reload file from disk and discard changes
command!  -nargs=0 R e! %

" quickly switch between absolute and relative line numbers
" "number" option was set at the beginning of the file
let g:___number_active=1
function! NumSwap()
  if g:___number_active
    set relativenumber
    let g:___number_active = 0
  else
    set number
    let g:___number_active = 1
  endif
endf

nmap <silent> <leader>l :call NumSwap()<cr>

" split management
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
