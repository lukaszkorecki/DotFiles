" indenthl.vim: hilights each indent level in different colors.
" Author: Dane Summers
" Date: Feb 15, 2007
" Version: 2
" 
" See :help mysyntaxfile-add for how to install this file.


syn match cTab1 /^[\s\s\s\s]/
syn match cTab2 /\(^\s\s\s\s)\@<=\s\s\s\s/
syn match cTab3 /\(^\s\s\s\s\{2}\)\@<=\s\s\s\s/
syn match cTab4 /\(^\s\s\s\s\{3}\)\@<=\s\s\s\s/
syn match cTab5 /\(^\s\s\s\s\{4}\)\@<=\s\s\s\s/
syn match cTab6 /\(^\s\s\s\s\{5}\)\@<=\s\s\s\s/
syn match cTab7 /\(^\s\s\s\s\{6}\)\@<=\s\s\s\s/

" syn match cTab1 /^[\t]/
" syn match cTab2 /\(^\t\)\@<=\t/
" syn match cTab3 /\(^\t\{2}\)\@<=\t/
" syn match cTab4 /\(^\t\{3}\)\@<=\t/
" syn match cTab5 /\(^\t\{4}\)\@<=\t/
" syn match cTab6 /\(^\t\{5}\)\@<=\t/
" syn match cTab7 /\(^\t\{6}\)\@<=\t/

command! -nargs=+ HiLink hi def <args>
" to make colors slightly darker at each level (in gui)
HiLink cTab1 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray90
HiLink cTab2 term=NONE cterm=NONE ctermbg=gray gui=NONE guibg=gray85
HiLink cTab3 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray80
HiLink cTab4 term=NONE cterm=NONE ctermbg=gray gui=NONE guibg=gray75
HiLink cTab5 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray70
HiLink cTab6 term=NONE cterm=NONE ctermbg=gray gui=NONE guibg=gray65
HiLink cTab7 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray60
" all alternating colors:
"HiLink cTab1 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
"HiLink cTab2 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
"HiLink cTab3 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
"HiLink cTab4 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
"HiLink cTab5 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
"HiLink cTab6 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
"HiLink cTab7 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
" all alternating colors, but it gets darker with each alternate:
"HiLink cTab1 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
"HiLink cTab2 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
"HiLink cTab3 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
"HiLink cTab4 term=NONE cterm=NONE ctermbg=brown gui=NONE guibg=gray85
"HiLink cTab5 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
"HiLink cTab6 term=NONE cterm=NONE ctermbg=blue gui=NONE guibg=gray75
"HiLink cTab7 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
delcommand HiLink
