" blockhl.vim: highlights different levels of {} with different shades of
"              grey.  Only good for gvim and C/C++.
"  Author: Charles E. Campbell, Jr.
"  Date:   Jul 01, 2004
"  Version: 4
"  History:
"     4  : Jul 01, 2004: optionally supports entire-line rather than just
"                        leading whitespace
"                        uses cursorhold to restore highlighting after a
"                        colorscheme change
"                        bugfix: an ALLBUT in cParen caused cCurly7
"                        to do inside-() highlighting.
"     3  : Jun 30, 2004: now supports dark and light background settings
"     2  : Jun 24, 2002: has("menu") now part of test
"     1  : the epoch   :
if !exists("g:blockhl_loaded")
 let g:blockhl_loaded= 1
else
 let g:blockhl_loaded= 2
endif

if has("gui_running")
 
 " Block Highlighting Syntax: {{{1
 if g:blockhl_loaded == 1
  syn cluster cCurlyGroup	   contains=cConditional,cConstant,cLabel,cOperator,cRepeat,cStatement,cStorageClass,cStructure,cType,cBitField,cCharacter,cCommentError,cInclude,cNumbers,cParenError,cPreCondit,cSpaceError,cSpecialCharacter,cSpecialError,cUserCont,cBracket,cComment,cCommentL,cCppOut,cCppString,cDefine,cMulti,cParen,cPreCondit,cPreProc,cString
  syn cluster cParenGroup	   add=cCurly1,cCurly2,cCurly3,cCurly4,cCurly5,cCurly6,cCurly7,cLead1,cLead2,cLead3,cLead4,cLead5,cLead6,cLead7
  syn region cCurly1		   transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead1,cCurly2,@cCurlyGroup
  syn region cCurly2 contained transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead2,cCurly3,@cCurlyGroup
  syn region cCurly3 contained transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead3,cCurly4,@cCurlyGroup
  syn region cCurly4 contained transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead4,cCurly5,@cCurlyGroup
  syn region cCurly5 contained transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead5,cCurly6,@cCurlyGroup
  syn region cCurly6 contained transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead6,cCurly7,@cCurlyGroup
  syn region cCurly7 contained transparent	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=cLead7,cCurly1,@cCurlyGroup
 
  syn match  cLead1	contained	"^\s\+"
  syn match  cLead2	contained	"^\s\+"
  syn match  cLead3	contained	"^\s\+"
  syn match  cLead4	contained	"^\s\+"
  syn match  cLead5	contained	"^\s\+"
  syn match  cLead6	contained	"^\s\+"
  syn match  cLead7	contained	"^\s\+"

  " HLTest: tests if a highlighting group has been set up {{{1
  "         This function is used by the CursorHold below, which
  "         is there primarily to support continued blockhl
  "         highlighting after the colorscheme has been changed
  fun! BlockHLTest(hlname)
    let id_hlname= hlID(a:hlname)
    if id_hlname == 0
     return 0
    endif
    let id_trans = synIDtrans(id_hlname)
    if id_trans == 0
     return 0
    endif
    let fg_hlname= synIDattr(id_trans,"fg")
    let bg_hlname= synIDattr(id_trans,"bg")
    if fg_hlname == "" && bg_hlname == ""
     return 0
    endif
    return 1
  endfun
  let g:blockhl_path= expand("<sfile>")
  exe 'au CursorHold * silent if !BlockHLTest("cLead1")|so '.g:blockhl_path."|endif"
 endif

 " Blockhl Highlighting Groups:	{{{1
 if version < 508
   command! -nargs=+ HiLink hi <args>
 else
   command! -nargs=+ HiLink hi def <args>
 endif
 
 if &bg == "dark"
  HiLink cLead1 term=NONE cterm=NONE gui=NONE guibg=grey10
  HiLink cLead2 term=NONE cterm=NONE gui=NONE guibg=grey20
  HiLink cLead3 term=NONE cterm=NONE gui=NONE guibg=grey25
  HiLink cLead4 term=NONE cterm=NONE gui=NONE guibg=grey30
  HiLink cLead5 term=NONE cterm=NONE gui=NONE guibg=grey35
  HiLink cLead6 term=NONE cterm=NONE gui=NONE guibg=grey40
  HiLink cLead7 term=NONE cterm=NONE gui=NONE guibg=grey45
 else
  HiLink cLead1 term=NONE cterm=NONE gui=NONE guibg=grey90
  HiLink cLead2 term=NONE cterm=NONE gui=NONE guibg=grey80
  HiLink cLead3 term=NONE cterm=NONE gui=NONE guibg=grey75
  HiLink cLead4 term=NONE cterm=NONE gui=NONE guibg=grey70
  HiLink cLead5 term=NONE cterm=NONE gui=NONE guibg=grey65
  HiLink cLead6 term=NONE cterm=NONE gui=NONE guibg=grey60
  HiLink cLead7 term=NONE cterm=NONE gui=NONE guibg=grey55
 endif
 delcommand HiLink
endif
" vim: ts=4 fdm=marker
