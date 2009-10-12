" Name Of File:    UnMtchBracket.vim
" Description:     Vim Plugin to capture those unmatched brackets while
"                  you are still in insert mode.
" Maintainer:      Naveen Chandra R (ncr at iitbombay dot org)
" URL:             http://www.geocities.com/ncr_10/vim.html
" Last Change:     Tuesday, October 15, 2002
" Version:         2.0
" Install Details: Normally, this file should reside in the plugins
"                  directory and be automatically sourced. If not, you 
"                  must manually source this file using 
"                  ':so UnMtchBracket.vim'.
" Description:     This script highlights any unmatched '(', '{' or '[' 
"                  and warns the user if an extra ')', '}' or ']' is 
"                  typed.
" Customization:   
"                  - Specifying Additional Bracket-pairs.
"                         User can specify additional matching pairs in
"                    the global option 'matchpairs', see :help mps
"                    For eg: set mps+=<:> (to include <> pair)
"                    put the above setting in .vimrc file and restart 
"                    vim.
"                  - To get rid of highlighting when you quit insert
"                    mode, add this mapping in your vimrc
"                        noremap! <Esc> <Esc>:match NONE<CR>
" Change Log:      
"                  - Added support for defining additional bracket 
"                    pairs through matchpairs.
"                  - Elliminated those irksome errorbells by silent!
"                  - Added support for highlighting brackets within the
"                    displayed lines i.e. highlighting the brackets is 
"                    done only in the currently displayed lines 
"                    eventhough the matching bracket is outside the 
"                    currently displayed lines.
"                  - Elliminated those visual jerks or shifting of 
"                    editing line.
" ----------------------------------------------------------------------


" Exit if this plugin is already loaded.
if exists("loaded_hiunbrkt") || &cp
    finish
endif


" Defining Mappings
" -----------------
let s:brackets = &mps
let s:brackets = substitute(s:brackets,"[:,]","","g")
let s:len = strlen(s:brackets)
while s:len > 0
    let s:rb = strpart(s:brackets, s:len -1, 1)
    exe 'inoremap '.s:rb.' '.s:rb.'<Esc>:call MatchedBracket()<CR>a'
    let s:len = s:len - 1
    let s:lb = strpart(s:brackets, s:len -1, 1)
    exe 'inoremap '.s:lb.' '.s:lb.'<Esc>:silent call HiCursor()<CR>a'
    let s:len = s:len - 1
endwhile

let loaded_hiunbrkt=1

" Map <Esc> key to remove all hilightings.
"noremap! <Esc> <Esc>:match NONE<CR>


" Functions
" ---------
function! HiCursor()
    exe 'match Error /\%'.line('.').'l\%'.col('.').'c/'
endfunction

function! MatchedBracket()
    let s:editline = line('.')
    let s:editcol = virtcol('.')
    silent! norm! %
    let l:curline = line('.')
    let l:curcol = virtcol('.')
    if(s:editline == l:curline && s:editcol == l:curcol)
        echohl ErrorMsg
        echon "Error: Extra " . getline(".")[col(".") - 1]
        echohl None
        return
    endif
"    exe 'match Normal /\%'.l:curline.'l\%'.l:curcol.'c/'
    exe 'match NONE'

    exe "normal! ".s:editline."G".s:editcol."|"
    let s:wline = FirstWindowLine()

    let s:hline = s:wline
    let s:hcol = 0
    let l:flag = 0
    let s:brackets = &mps
    let s:brackets = substitute(s:brackets,"[:,]","","g")
    let l:len = strlen(s:brackets)
    while l:len > 0
        let l:countRB = 0
        let l:rb = strpart(s:brackets, l:len -1, 1)
        let l:countRB = CountBracket(l:rb)
        let l:len = l:len - 1
        let l:lb = strpart(s:brackets, l:len -1, 1)
        let l:countLB = 0
        let l:countLB = CountBracket(l:lb)
        let l:len = l:len - 1
        if l:countLB > l:countRB
            call FindHighlightableLoc(l:lb,l:rb,l:countRB)
            let l:flag = 1
        else
            exe "normal! ".s:editline."G".s:editcol."|"
        endif
    endwhile

    if(l:flag == 1)
        exe "normal! ".s:hline."G".s:hcol."|"
        call HiCursor()
    endif
    exe "normal! ".s:wline."G"
    norm! zt
    exe "normal! ".s:editline."G".s:editcol."|"
endfunction

function! FindHighlightableLoc(lbkt,rbkt,count)
    exe "normal! ".s:editline."G".s:editcol."|"
"   if(search("\\V" . a:lbkt . "\\m", "bW") > 0)
"       let l:curcount = searchpair(a:lbkt,'',a:rbkt, 'nmrW')
"   else
"       let l:curcount = 0
"   endif
"   while ( l:curcount > 0 && search("\\V" . a:lbkt . "\\m", "bW") > 0)
"       let l:curcount = l:curcount - 1
"   endwhile

    
    if s:GotoUnMtchBrkt(a:lbkt)
        let l:suggline = line('.')
        let l:suggcol = virtcol('.')
        if (l:suggline < s:wline)
            call FindFirstLoc(a:lbkt)   
        else
            call HoldMax(l:suggline, l:suggcol)
        endif
    endif
    exe "normal! ".s:editline."G".s:editcol."|"
endfunction

function! HoldMax(linenr, colnr)
    if(a:linenr > s:hline)
        let s:hline = a:linenr
        let s:hcol = a:colnr
    elseif(a:linenr == s:hline && a:colnr > s:hcol)
            let s:hcol = a:colnr
    endif
endfunction
    
function! FindFirstLoc(bkt)
    exe "normal! ".s:wline."G0|"
    if(search("\\V". a:bkt ."\\m", "W") > 0)
        let l:fline = line('.')
        let l:fcol = virtcol('.')
        call HoldMax(l:fline, l:fcol)
    endif
    exe "normal! ".s:editline."G".s:editcol."|"
endfunction

function! CountBracket(bkt)
    let l:bktcount = 0
    let l:curline = line('.')
    let l:curcol = virtcol('.')
    exe "normal! 1G0|"
    while (search("\\V" . a:bkt . "\\m", "W") > 0)
        let l:bktcount = l:bktcount + 1
    endwhile
    exe "normal! ".l:curline."G".l:curcol."|"
    return l:bktcount
endfunction

function! FirstWindowLine()
    norm! H
    return line('.')
endfunction

function! s:GotoUnMtchBrkt(bkt)
    let s:curline = line('.')
    let s:curcol = virtcol('.')
"   exe "normal! [".a:bkt
    let l:tmp = search("\\V" . a:bkt . "\\m", "bW") 
    let s:prevline = line('.')
    let s:prevcol = virtcol('.')
    if(s:curcol != s:prevcol || s:curline != s:prevline) 
        silent! norm! %
        if(s:prevcol == virtcol('.') && s:prevline == line('.'))
            return 1
        else
            silent! norm! %
            return s:GotoUnMtchBrkt(a:bkt)
        endif
    endif
    return 0
endfunction

