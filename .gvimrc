syntax on
" line numbers
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set nocompatible
"set guifont=Consolas:h8:b:cANSI 
set bs=2
set cul
set incsearch
set cursorline
set cursorcolumn
set number
set list
set listchars=tab:\.\ ,trail:-
set ruler
set showcmd
set guifont=DejaVu\ Sans\ Mono:h11.00
" turn off the scrollbars"
set guioptions=emgtT 

" PHP specific fixes
" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query=1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings=1
" discourages use oh short tags. c'mon its deprecated remember
autocmd FileType php let php_noShortTags=1

inoremap <C-B> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-B> :call PhpDocSingle()<CR>
vnoremap <C-B> :call PhpDocRange()<CR> 


filetype plugin on
filetype on
" settings for cake
au BufNewFile  *.ctp set filetype=php
au BufRead *.ctp set filetype=php
" autoindenting
set cindent
set smartindent
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" folding
set foldenable
set foldmarker={,}
set laststatus=2

" temp files
set backupdir=~/.vim/bak
set directory=~/.vim/tmp
" colorz
colorscheme molokai
"colorscheme herald
""colorscheme zenburn
"colorscheme wombat
" colorscheme fix?
if &term =~ "xterm"
  "256 color --
  let &t_Co=256
  " restore screen after quitting
   set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
   if has("terminfo")
       let &t_Sf="\ESC[3%p1%dm"
       let &t_Sb="\ESC[4%p1%dm"
   else
       let &t_Sf="\ESC[3%dm"
       let &t_Sb="\ESC[4%dm"
       
   endif
 endif

 " twitter settings
let twitvim_login_b64 = ""
" set to identica only 
let twitvim_api_root = "http://identi.ca/api"
nnoremap <F8> :FriendsTwitter<cr>
nnoremap <S-F8> :UserTwitter<cr>
nnoremap <A-F8> :RepliesTwitter<cr>
nnoremap <C-F8> :DMTwitter<cr>
" account switcher for identi.ca <-> twitter
function! Switch_to_twitter()
    let g:twitvim_api_root = "http://twitter.com"
    FriendsTwitter
endfunction

function! Switch_to_identica()
    let g:twitvim_api_root = "http://identi.ca/api"
    FriendsTwitter
endfunction

command! ToTwitter :call Switch_to_twitter()
command! ToIdentica :call Switch_to_identica()
	
 " allml settings
 let g:allml_global_maps = 1
