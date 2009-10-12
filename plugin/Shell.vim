" FILE: /user/prince/Vim/Functions/Shell.vim
" AUTHOR: Janakiraman .S <prince@india.ti.com>
" Last Modified: Sat, 18 Aug 2001 10:34:07 (IST)
" Usage: Just source this file.
"        source Shell.vim
" LICENSE: No Warranties. Use at  your own risk. Add stuff to taste.
"          If you like this script type :help uganda<Enter>
"          If you want to show appreciation to the author, please
"          visit the UDAVUM KARANGAL website http://www.udavumkarangal.org/
" NOTES: Written to work with vim-5.7.

nmap \s :call InitShell()<cr>

func! InitShell ()
  if (expand("%:p:t")=="_vimshell.tmp")
    echo "Already there"
    call ShellInitSyntax()
    call PrintPrompt()
  else
    if ( bufexists ("_vimshell.tmp") )
      let a = bufwinnr("_vimshell.tmp")
      if ( a == -1 )
	sb _vimshell.tmp
	call ShellInitSyntax()
      else
	execute "normal ".a."\<C-w>w"
      endif
    else
      sp _vimshell.tmp
      call ShellInitSyntax()
    endif
    call PrintPrompt()
  endif
endfunction

func! PrintPrompt ()
  " If we had quit the window, The buffer might exist but its
  " contents are lost. Making sure there is a prompt in the last line
  " let @a = getline(".")
  let @a = getline("$")
  let foo = escape (@a,"\'")
  exec "let a = matchstr(\'".foo."\',\'".g:PROMPT."\')"
  if ( a == "" )
    if !( getline(".") == "" )
      execute "normal o"."\<Esc>"
    endif
    exec "normal "."i\<C-R>=g:PROMPT\<CR>\<Esc>"
  else
    " If the line we are on has only the prompt , place the cursor at the end.
    let @a = getline(".")
    let foo = escape (@a,"\'")
    exec "let b = matchstr(\'".foo."\',\'".g:PROMPT."\\s*$\')"
    if !( b == "" )
      normal $
    endif
  endif
  let &modified = 0
endfunction

func! ShellInitSyntax()
  if !( exists("g:PROMPT") )
    let g:PROMPT = "{Shell}"
  endif
  exec "syn match VimShellType " . "\"".g:PROMPT."\""
  exec "hi link VimShellType LineNr"
endfunction

func! ProcessEnter()
  normal 0
  normal "ayy 
  let foo = escape (@a,"\'")
  exec "let a = matchstr(\"".substitute(foo,'"','\\\"',"g")."\",\"".g:PROMPT."\")"
  " exec "let a = matchstr(\'".substitute(foo,'"','\\\"',"g")."\',\'".g:PROMPT."\')"
  " If the line does not match the prompt. It was probably the
  " output of a previously executed command. DONT execute those
  " as commands.
  if ( a == "" )
    echo "Not on the command line"
    normal j
  else
    exec "let @a = substitute(@a,\"".g:PROMPT."\",\"\",\"\")"
    if ( line(".") != line("$") )
      if ( ( @a =~ "\\w" ) && ( &modified == 0 ) )
	normal "aP
	exec "normal "."i\<C-R>=g:PROMPT\<CR>\<Esc>"
      endif
    endif
    " If the command is a cd, Change the working directory.
    let currline = 0
    if ( @a =~ "^cd\\>" )
      let @a = ":".@a
      normal @a
      if ( line(".") == line("$") )
	execute "normal o"."\<Esc>"
      endif
    " If it says clean, Clean up the screen.
    else
      if ( @a =~ "^clear\\>" )
	let @a = "ggdG"
	normal @a
      else
	if ( @a =~ "\\w" )
	  if ( @a =~ 'man' )
	    let currline = line(".")
	  else
	    let currline = 0
	  endif
	  let @a = ":r!".@a
          normal @a
          if ( line(".") == line("$") )
            execute "normal o"."\<Esc>"
          endif
	  if ( currline )
	    let lastline = line(".")
	    let Oldreport = &report
	    let &report = 10000
	    exec currline.",".lastline.'!col -b'
	    exec currline.",".lastline.'!uniq -u'
	    let &report = Oldreport
	    normal G
	  endif
	else
	  if ( line(".") == line("$") )
	    execute "normal o"."\<Esc>"
	  endif
	endif
      endif
    endif
    call PrintPrompt()
    " if ( currline )
    "   exec currline + 1
    " endif
  endif
endfunction

augroup VimShellStuff
  au!
  au BufEnter _vimshell.tmp let &swapfile=0
  au BufEnter _vimshell.tmp nnoremap <cr> :call ProcessEnter()<cr>
  au BufLeave _vimshell.tmp nun <cr>
  au BufEnter _vimshell.tmp inoremap <cr> <Esc>:call ProcessEnter()<cr>
  au BufLeave _vimshell.tmp iunmap <cr>
  au BufEnter _vimshell.tmp nm q :hide<CR>
  au BufLeave _vimshell.tmp nun q
augroup end
