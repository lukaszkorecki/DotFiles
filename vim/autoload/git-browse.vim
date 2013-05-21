" open a single line on github using git-browse
function! GitBrowseFile()
  let _line = line('v')
  let _file = expand('%')
  let cmd = "Git browse -r "._line." "._file
  echom cmd
  exec cmd
endf

" open a range of lines on github using git-browse
function! RangeGitBrowseFile() range
  let _file = expand('%')
  let _range="-r".a:firstline.",".a:lastline
  let cmd = "Git browse "._range." ".f
  echom cmd
  exec cmd
endf

nnoremap <leader>B :call GitBrowseFile()<CR>
vnoremap <leader>B :call RangeGitBrowseFile()<CR>

