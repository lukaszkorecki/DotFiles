" File: ruby-tools.vim
" Name: Ruby-tools
" Author: Łukasz Korecki
" Version: 0.1
" Last Modified: Tue 14 Dec 2010 23:07:21 GMT
"
" Collection of few nice functions which are supposed
" to make working with ruby easier and faster
"
" While there are already packages which offer same
" (and even bigger) set of functionality - my goal
" was to keep everything simple, plain and make it do few things
" but doing them right.
"
" All Commands have RR prefix

if exists('g:loaded_autoload_ruby_tools') || v:version < 702
  finish
endif
let g:loaded_autoload_ruby_tools = 1

" RUBY
" ----

" Lists functions/methods in current file
function! g:ListRubyFunctions()
  let s:file_name = expand("%")

  exe 'lvimgrep =def = ' . s:file_name

  vertical lopen
  vertical resize 50

  set modifiable
  silent exe '%s=' . s:file_name . '==g'
  silent exe '%s/def //g'
  silent exe '%s$ col \d*$$g'
  setlocal nomodified
  set nomodifiable
  set readonly
endfunction

" Searches for function/method definition under the cursor
function! g:GotoRubyFunc()
  let find_command = 'find . -type f | grep .rb  | xargs grep -n def\ '.expand('<cword>')
  echo(find_command)
  set errorformat=%f:%l:%m
  lgetexpr system(find_command)
  rightb lopen
endfunction


" RSPEC
" -----

" Executes spec (rspec 1.3) command in different modes
" and display results in :Error buffer
" available modes:
" - file - all specs in current file
" - line - current context or current example (cursor within context {} or it   {} block
" - all - runs whole test case
function! g:RunRspec(mode)
  if a:mode == 'line'
    let line_num = line(".")
    let res =  system('spec -l '.line_num.' '.expand('%'))
  elseif a:mode == 'file'
    let res = system('spec '.expand('%'))
  elseif a:mode == 'all'
    let res = system('RAILS_ENV=test rake spec')
  endif
  vnew
  let e_file = tempname()
  silent execute 'e '.e_file
  put = res
  silent w | bd
  set errorformat=%f:%l:
  silent execute 'cgetfile '.e_file
  copen
endfunction

command! -bar -narg=* RRRGotoDef call g:GotoRubyFunc()
command! -bar -narg=* RRListDefs call g:ListRubyFunctions()

command! -bar -narg=0 RRSpecF call g:RunRspec('file')
command! -bar -narg=0 RRSpecL call g:RunRspec('line')
command! -bar -narg=0 RRSpecAll call g:RunRspec('all')
