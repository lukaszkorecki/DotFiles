" HiMtchBrkt : highlights matching brackets and, optionally, containing
"              brackets
"  Author:  Charles E. Campbell, Jr.  <drNchipO@ScampbellPfamilyA.Mbiz>-NOSPAM
"  Date:    Feb 28, 2006
"  Version: 22
"
" A Vim v6.0/7.0 plugin with menus for gvim
"
" Usage: {{{1
"   \[i : initialize highlighting of matching bracket
"   \[s : stop       highlighting of matching bracket
"
"   Actually, <Leader> is used, so you may set mapleader to change
"   the leading backslash to whatever you want in your <.vimrc>
"   See :help mapleader.
"
" GetLatestVimScripts: 1435 1 :AutoInstall: HiMtchBrkt.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_HiMtchBrkt")
 finish
endif
let g:loaded_HiMtchBrkt = "v22"
let s:keepcpo           = &cpo
set cpo&vim
if exists("g:hicurline_ut") && !exists("g:HiMtchBrkt_ut")
 let g:HiMtchBrkt_ut= g:hicurline_ut
endif
if v:version >= 700 && exists("##CursorMoved")
 let g:loaded_matchparen= 1
endif

" ---------------------------------------------------------------------
" Public Interface: {{{1
if !hasmapto('<Plug>HMBStart')
 map <unique> <Leader>[i	<Plug>HMBStart
endif
if !hasmapto('<Plug>HMBStop')
 map <unique> <Leader>[s	<Plug>HMBStop
endif
com! -bang HMBstart    :set lz|call s:HMBStart(<bang>0)|set nolz
com! -bang HMBstop     :set lz|call s:HMBStop(<bang>0)|set nolz
com! -bang HMBsurround :set lz|call s:HMBSurround(<bang>1)|set nolz

" ---------------------------------------------------------------------
" Global Maps: {{{1
nmap <silent> <unique> <script> <Plug>HMBStart :set lz<CR>:call <SID>HMBStart()<CR>:set nolz<CR>
nmap <silent> <unique> <script> <Plug>HMBStop  :set lz<CR>:call <SID>HMBStop()<CR>:set nolz<CR>

" ---------------------------------------------------------------------
" DrChip Menu Support: {{{1
if has("menu") && has("gui_running") && &go =~ 'm'
 if !exists("g:DrChipTopLvlMenu")
  let g:DrChipTopLvlMenu= "DrChip."
 endif
 exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[i	<Leader>[i'
 exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On<tab>:HMBsurround	:HMBsurround'
endif

" =====================================================================
" HMBStart: {{{1
fun! <SID>HMBStart(mode)
"  call Dfunc("HMBStart(mode=".a:mode.")")

  " set whichwrap
  let s:wwkeep    = &ww
  set ww=b,s,<,>,[,]

  if exists("g:dohimtchbrkt") && g:dohimtchbrkt == 1
   " already in HiMtchBrkt mode
   if &cmdheight >= 2 && a:mode == 0
    echo "[HiMtchBrkt]"
   endif
"   call Dret("HMBStart : already in HiMtchBrkt mode")
   return
  endif
  let g:dohimtchbrkt= 1
 
  " indicate in HiMtchBrkt mode
  if &cmdheight >= 2 && a:mode == 0
   echo "[HiMtchBrkt]"
  endif
 
  if v:version >= 700 && exists("##CursorMoved")
   " assuming snapshot#195 or later
   augroup HMBEvent
   	au!
    au CursorMoved * silent call s:HiMatchBracket()
   augroup END
  else
   " Save Maps (if any)
   call SaveUserMaps("n","",":F(","HiMtchBrkt")
   call SaveUserMaps("n","",":F)","HiMtchBrkt")
   call SaveUserMaps("n","",":F[","HiMtchBrkt")
   call SaveUserMaps("n","",":F]","HiMtchBrkt")
   call SaveUserMaps("n","",":F{","HiMtchBrkt")
   call SaveUserMaps("n","",":F}","HiMtchBrkt")
   call SaveUserMaps("n","",":f(","HiMtchBrkt")
   call SaveUserMaps("n","",":f)","HiMtchBrkt")
   call SaveUserMaps("n","",":f[","HiMtchBrkt")
   call SaveUserMaps("n","",":f]","HiMtchBrkt")
   call SaveUserMaps("n","",":f{","HiMtchBrkt")
   call SaveUserMaps("n","",":f}","HiMtchBrkt")
   call SaveUserMaps("n","","<c-b>","HiMtchBrkt")
   call SaveUserMaps("n","","<c-d>","HiMtchBrkt")
   call SaveUserMaps("n","","<c-f>","HiMtchBrkt")
   call SaveUserMaps("n","","<c-u>","HiMtchBrkt")
   call SaveUserMaps("n","","<down>","HiMtchBrkt")
   call SaveUserMaps("n","","<PageDown>","HiMtchBrkt")
   call SaveUserMaps("n","","<end>","HiMtchBrkt")
   call SaveUserMaps("n","","<home>","HiMtchBrkt")
   call SaveUserMaps("n","","<left>","HiMtchBrkt")
   call SaveUserMaps("n","","<right>","HiMtchBrkt")
   call SaveUserMaps("n","","<space>","HiMtchBrkt")
   call SaveUserMaps("n","","<up>","HiMtchBrkt")
   call SaveUserMaps("n","","<PageUp>","HiMtchBrkt")
   call SaveUserMaps("n","","webWEBjklh$0%;,nN","HiMtchBrkt")
   call SaveUserMaps("o","","<down>","HiMtchBrkt")
   call SaveUserMaps("o","","<end>","HiMtchBrkt")
   call SaveUserMaps("o","","<home>","HiMtchBrkt")
   call SaveUserMaps("o","","<left>","HiMtchBrkt")
   call SaveUserMaps("o","","<right>","HiMtchBrkt")
   call SaveUserMaps("o","","<up>","HiMtchBrkt")
   if has("gui_running") && has("mouse")
    call SaveUserMaps("n","","<leftmouse>","HiMtchBrkt")
    call SaveUserMaps("o","","<leftmouse>","HiMtchBrkt")
   endif
   if v:version > 602 || v:version == 602 && has("patch405")
    call SaveUserMaps("n","","0","HiMtchBrkt")
   endif
  
   " Install HiMtchBrkt maps
   if has("gui_running")
    call s:HMBMapper("<down>"    , "<down>"    , "<down>")
    call s:HMBMapper("<up>"      , "<up>"      , "<up>")
    call s:HMBMapper("<right>"   , "<right>"   , "<right>")
    call s:HMBMapper("<left>"    , "<left>"    , "<left>")
    call s:HMBMapper("<home>"    , "<home>"    , "<home>")
    call s:HMBMapper("<end>"     , "<end>"     , "<end>")
    call s:HMBMapper("<space>"   , "<space>"   , "")
    call s:HMBMapper("<PageUp>"  , "<PageUp>"  , "<PageUp>")
    call s:HMBMapper("<PageDown>", "<PageDown>", "<PageDown>")
   else
    call s:HMBMapper("<down>"    , "j"    , "<c-o>j"    )
    call s:HMBMapper("<up>"      , "k"    , "<c-o>k"    )
    call s:HMBMapper("<right>"   , "l"    , "<c-o>l"    )
    call s:HMBMapper("<left>"    , "h"    , "<c-o>h"    )
    call s:HMBMapper("<home>"    , "0"    , "<c-o>0"    )
    call s:HMBMapper("<end>"     , "$"    , "<c-o>$"    )
    call s:HMBMapper("<space>"   , "l"    , ""          )
    call s:HMBMapper("<PageUp>"  , "<c-b>", "<c-o><c-b>")
    call s:HMBMapper("<PageDown>", "<c-f>", "<c-o><c-f>")
   endif
   if has("gui_running") && has ("mouse")
    call s:HMBMapper("<leftmouse>","<leftmouse>","<leftmouse>")
   endif
   if v:version > 602 || v:version == 602 && has("patch405")
    call s:HMBMapper('0'    , '0'    , '')
   endif
   call s:HMBMapper('b'    , 'b'    , '')
   call s:HMBMapper('B'    , 'B'    , '')
   call s:HMBMapper('e'    , 'e'    , '')
   call s:HMBMapper('E'    , 'E'    , '')
   call s:HMBMapper('h'    , 'h'    , '')
   call s:HMBMapper('j'    , 'j'    , '')
   call s:HMBMapper('k'    , 'k'    , '')
   call s:HMBMapper('l'    , 'l'    , '')
   call s:HMBMapper('n'    , 'n'    , '')
   call s:HMBMapper('N'    , 'N'    , '')
   call s:HMBMapper('$'    , '$'    , '')
   call s:HMBMapper('%'    , '%'    , '')
   call s:HMBMapper('w'    , 'w'    , '')
   call s:HMBMapper('W'    , 'W'    , '')
   call s:HMBMapper("<c-f>", "<c-f>", "")
   call s:HMBMapper("<c-b>", "<c-b>", "")
   call s:HMBMapper("<c-d>", "<c-d>", "")
   call s:HMBMapper("<c-u>", "<c-u>", "")
   call s:HMBMapper('f('   , 'f('   , '')
   call s:HMBMapper('f)'   , 'f)'   , '')
   call s:HMBMapper('f{'   , 'f{'   , '')
   call s:HMBMapper('f}'   , 'f}'   , '')
   call s:HMBMapper('f['   , 'f['   , '')
   call s:HMBMapper('f]'   , 'f]'   , '')
   call s:HMBMapper('F('   , 'F('   , '')
   call s:HMBMapper('F)'   , 'F)'   , '')
   call s:HMBMapper('F{'   , 'F{'   , '')
   call s:HMBMapper('F}'   , 'F}'   , '')
   call s:HMBMapper('F['   , 'F['   , '')
   call s:HMBMapper('F]'   , 'F]'   , '')
   if exists("mapleader")
    if mapleader != ';'
    	call s:HMBMapper(';',';','')
    endif
    if mapleader != ','
    	call s:HMBMapper(',',',','')
    endif
   else
    	call s:HMBMapper(';',';','')
    	call s:HMBMapper(',',',','')
   endif
 
   " use CursorHold event to do a belated highlighing of matching bracket
   " to handle motions not directly handled above
   if !exists("g:HiMtchBrkt_nocursorhold") && (!exists("g:HiMtchBrkt_ut") || g:HiMtchBrkt_ut != 0)
    " keep and set options
    let g:HiMtchBrkt_utkeep= &ut
    if exists("g:HiMtchBrkt_ut")
    	let &ut= g:HiMtchBrkt_ut
    else
    	" I'd like to set ut even faster, but unfortunately that clears
     " status-line messages before people have a chance to read them
     set ut=2000
    endif
    augroup HMBEvent
     au!
     au CursorHold * if getline(line(".")) != "" | silent call s:HiMatchBracket() | endif
    augroup END
   endif
  endif
 
  " Insert stop  HiMtchBrkt into menu
  " Delete start HiMtchBrkt from menu
  if has("gui_running") && has("menu")
   exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop<tab><Leader>[s	<Leader>[s'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ Off'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On'
   if exists("g:HiMtchBrkt_surround") && g:HiMtchBrkt_surround
    exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ Off<tab>:HMBsurround!	:HMBsurround!'."\<cr>"
   else
    exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On<tab>:HMBsurround	:HMBsurround'."\<cr>"
   endif
  endif
 
"  call Dret("HMBStart")
endfun

" ---------------------------------------------------------------------
" HMBStop: turn  HiMtchBrkt mode off: restore motion key maps to prior {{{1
" settings (if any), restore visual beeps, restore CursorHold update timer.
fun! <SID>HMBStop(mode)
"  call Dfunc("HMBStop(mode=".a:mode.")")
  if !exists("g:dohimtchbrkt")
   if &cmdheight >= 2 && a:mode == 0
    echo "[HiMtchBrkt off]"
   endif
"   call Dret("HMBStop")
   return
  endif
  unlet g:dohimtchbrkt
  match none
 
  " remove cursorhold event for highlighting matching bracket
  if (v:version >= 700 && exists("##CursorMoved")) || !exists("g:HiMtchBrkt_nocursorhold")
   augroup HMBEvent
    au!
   augroup END
  endif
 
  if &cmdheight >= 2
   echo "[HiMtchBrkt off]"
  endif
 
  " restore user map(s), if any
  if v:version < 700
   call RestoreUserMaps("HiMtchBrkt")
  endif
  let &ww= s:wwkeep
 
  " Insert start HiMtchBrkt into menu
  " Delete stop  HiMtchBrkt from menu
  if has("gui_running") && has("menu")
   exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[s	<Leader>[i'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ Off'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On'
   if exists("g:HiMtchBrkt_surround") && g:HiMtchBrkt_surround
    exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ Off<tab>:HMBsurround!	:HMBsurround!'."\<cr>"
   else
    exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On<tab>:HMBsurround	:HMBsurround'."\<cr>"
   endif
  endif
"  call Dret("HMBStop")
endfun

" ---------------------------------------------------------------------
" HiMatchBracket: this routine actually performs the highlighting of {{{1
" the matching bracket.
fun! <SID>HiMatchBracket()
"  call Dfunc("HiMatchBracket()")
"  call Decho(((exists("g:HiMtchBrkt_surround") && g:HiMtchBrkt_surround)? "surround" : "normal")." mode")

  if mode() =~ '['."\<c-v>".'vV]'
   " don't try to highlight matching/surrounding brackets while in
   " visual-block mode
"   call Dret("HiMatchBracket")
   return
  endif

  " save
  let magickeep        = &magic
  let regdq            = @"
  let regunnamed       = @@
  let sokeep           = &so
  let sskeep           = &ss
  let sisokeep         = &siso
  let solkeep          = &sol
  let t_vbkeep         = &t_vb
  let vbkeep           = &vb
  silent! let regpaste = @*

  " turn beep/visual flash off
  set nosol vb t_vb= so=0 siso=0 ss=0 magic

  " remove every other character from the mps option set
  let mps= substitute(&mps,'\(.\).','\1','g')

  " grab a copy of the character under the cursor into @0
  silent! norm! yl

  " if the character grabbed in @0 is in the mps option set, then highlight
  " the matching character
"  call Decho("HiMatchBracket: stridx(mps<".mps.">,@0<".@0.">)=".stridx(mps,@0))
  if stridx(mps,@0) != -1
   if v:version >= 700 && exists("##CursorMoved")
   	let curchr     = @0
	" determine match line, column.
	" Restrict search to currently visible portion of window.
   	if &mps =~ curchr.':'
	 let stopline           = line("w$")
	 let chrmatch           = substitute(&mps,'^.*'.curchr.':\(.\).*$','\1','')
	 let [mtchline,mtchcol] = searchpairpos(escape(curchr,'[]'),'',escape(chrmatch,'[]'),'n','',stopline)
	else
	 let stopline           = line("w0")
	 let chrmatch           = substitute(&mps,'^.*\(.\):'.curchr.'.*$','\1','')
	 let [mtchline,mtchcol] = searchpairpos(escape(chrmatch,'[]'),'',escape(curchr,'[]'),'bn','',stopline)
	endif
"    call Decho("curchr<".curchr."> chrmatch<".chrmatch.">  searchpairpos[".mtchline.','.mtchcol.'] stopline='.stopline)
	if mtchline != 0 && mtchcol != 0
"     call Decho('exe match Search /\%'.mtchline.'l\%'.mtchcol.'c/')
	 exe 'match Search /\%'.mtchline.'l\%'.mtchcol.'c/'
    else
	 match none
    endif
   else
    let swp     = SaveWinPosn(0)
    let curline = line('.')
    let curcol  = virtcol('.')
	keepj norm! H
	let hline    = line('.')
	if hline != curline
		call RestoreWinPosn(swp)
	endif
	keepj norm! %
	let mtchline = line('.')
	let mtchcol  = virtcol('.')
	call RestoreWinPosn(swp)
"    call Decho('exe match Search /\%'.mtchline.'l\%'.mtchcol.'v/')
	exe 'match Search /\%'.mtchline.'l\%'.mtchcol.'v/'
   endif

  " if g:HiMtchBrkt_surround exists and is true, then highlight the surrounding brackets
  elseif exists("g:HiMtchBrkt_surround") && g:HiMtchBrkt_surround
   let swp        = SaveWinPosn(0)
   let openers    = '['.escape(substitute(&mps,':.,\=',"","g"),']').']'
   let closers    = '['.escape(substitute(&mps,',\=.:',"","g"),']').']'
"   call Decho("openers".openers." closers".closers)
   if v:version >= 700 && exists("##CursorMoved")
    call searchpair(openers,"",closers,'','',line("w$"))
   else
    call searchpair(openers,"",closers)
   endif

   silent! norm! yl
"   call Decho("surround: stridx(mps<".mps.">,@0<".@0.">)=".stridx(mps,@0))
   if stridx(mps,@0) != -1
	let mtchline1 = line('.')
	let mtchcol1  = virtcol('.')
	keepj norm! %
	let mtchline2 = line('.')
	let mtchcol2  = virtcol('.')
	call RestoreWinPosn(swp)
	exe 'match Search /\%'.mtchline1.'l\%'.mtchcol1.'v\|\%'.mtchline2.'l\%'.mtchcol2.'v/'
"    call Decho('match Search /\%'.mtchline1.'l\%'.mtchcol1.'v\|\%'.mtchline2.'l\%'.mtchcol2.'v/')
   else
	match none
   endif

  else
   match none
  endif
 
  " restore
  let &magic     = magickeep
  let @"         = regdq
  let @@         = regunnamed
  let &sol       = solkeep
  let &so        = sokeep
  let &siso      = sisokeep
  let &ss        = sskeep
  let &t_vb      = t_vbkeep
  let &vb        = vbkeep
  silent! let @* = regpaste

"  call Dret("HiMatchBracket")
endfun

" ---------------------------------------------------------------------
" HMBSurround: turns on HiMtchBrkt surround mode (brackets containing
" current cursor are highlighted).  If HiMtchBrkt is not enabled, then
" enabling with HMBsurround will also start HiMtchBrkt.  It doesn't
" stop HiMtchBrkt mode, though.  Instead, HiMtchBrkt will go to matching
" bracket highlighting mode.
fun! s:HMBSurround(mode)
"  call Dfunc("HMBsurround()")
  let g:HiMtchBrkt_surround= a:mode
  if g:HiMtchBrkt_surround
   if !exists("g:dohimtchbrkt")
    call s:HMBStart(0)
   endif
  endif
  call s:HiMatchBracket()
  if has("menu") && has("gui_running") && &go =~ 'm'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ Off'
   exe 'silent! unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On'
   if g:HiMtchBrkt_surround
    exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ Off<tab>:HMBsurround!	:HMBsurround!'."\<cr>"
   else
    exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Surround\ On<tab>:HMBsurround	:HMBsurround'."\<cr>"
   endif
  endif
"  call Dret("HMBsurround")
endfun

" ---------------------------------------------------------------------
" HMBMapper: {{{1
fun! s:HMBMapper(lhs,nrhs,irhs)
"  call Dfunc("HMBMapper(.lhs<".a:lhs."> nrhs<".a:nrhs."> irhs<".a:irhs.">)")

  " overload normal mode mapping
  let rhs= maparg(a:lhs,"n")
"  call Decho("rhs<".rhs.">")
  if rhs == "" | let rhs= a:nrhs | endif
  exe "nno <silent> ".a:lhs." ".rhs.":silent call <SID>HiMatchBracket()<CR>"
"  call Decho("exe nno <silent> ".a:lhs." ".rhs.":silent call <SID>HiMatchBracket()<CR>")

  if a:irhs != ""
  " overload insert mode mapping
   let rhs= maparg(a:lhs,"i")
"   call Decho("rhs<".rhs.">")
   if rhs == "" | let rhs= a:irhs | endif
   exe "ino <silent> ".a:lhs." ".rhs."<c-o>:silent call <SID>HiMatchBracket()<CR>"
"   call Decho("exe ino <silent> ".a:lhs." ".rhs."<c-o>:silent call <SID>HiMatchBracket()<CR>")
  endif
"  call Dret("HMBMapper")
endfun

" ---------------------------------------------------------------------
"  Auto Startup With HiMtchBrktOn: {{{1
if exists("g:HiMtchBrktOn") && g:HiMtchBrktOn != 0
 if !exists("*SaveUserMaps")
  " due to loading order, <plugin/cecutil.vim> may not have loaded yet.
  " attempt to force a load now.  Ditto for matchit!
  silent! runtime plugin/cecutil.vim
 endif
 silent! runtime plugin/matchit.vim
 silent HMBstart
endif

let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  vim: ts=4 fdm=marker
