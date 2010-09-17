if exists("loaded_git_view")
    finish
endif

let loaded_git_view = 1

if !exists('g:gitview_bufhidden')
    let g:gitview_bufhidden = ''
endif

if !exists('g:gitview_bin')
    let g:gitview_bin = 'git'
endif

" Show Status.
function! s:GitStatus()
    let gitv_output = s:SystemGit('status -s | grep -v /$ | colrm 1 3')
    call <SID>OpenGitBuffer(gitv_output)
    setlocal filetype=git-view
    nnoremap <buffer> <Enter> :call <SID>openBuf(expand("<cfile>"))<Enter>
    nnoremap <buffer> r       :call <SID>RefreshGitStatus()<Enter>
endfunction

function! s:RefreshGitStatus()
    let pos_save = getpos('.')
    call <SID>GitStatus()
    call setpos('.', pos_save)
endfunction

function! s:SystemGit(args)
    return system(g:gitview_bin . ' ' . a:args)
endfunction

function! s:OpenGitBuffer(content)
    if exists('b:is_gitv_msg_buffer') && b:is_gitv_msg_buffer
        edit!
    else
        execute "vsp;new"
    endif

    vertical resize 30

    setlocal buftype=nofile readonly modifiable
    execute 'setlocal bufhidden=' . g:gitview_bufhidden
    execute 'set nonumber'

    silent put=a:content
    keepjumps 0d
    setlocal nomodifiable

    let b:is_gitv_msg_buffer = 1
endfunction

"
" Shamelessly stolen from NERDTree
"

function! s:openBuf(path)
    "if the file is already open in this tab then just stick the cursor in it
    let winnr = bufwinnr('^' . a:path . '$')
    if winnr != -1
        call s:exec(winnr . "wincmd w")
    else
        if !s:isWindowUsable(winnr("#")) && s:firstUsableWindow() ==# -1
            call <SID>openSplit(a:path)
        else
            try
                if !s:isWindowUsable(winnr("#"))
                    call s:exec(s:firstUsableWindow() . "wincmd w")
                else
                    call s:exec('wincmd p')
                endif
                exec ("edit " . a:path)
            catch /^Vim\%((\a\+)\)\=:E37/
                throw "E37"
            catch /^Vim\%((\a\+)\)\=:/
                echo v:exception
            endtry
        endif
    endif
endfunction

function! s:isWindowUsable(winnumber)
    "gotta split if theres only one window (i.e. the NERD tree)
    if winnr("$") ==# 1
        return 0
    endif

    let oldwinnr = winnr()
    call s:exec(a:winnumber . "wincmd p")
    let specialWindow = getbufvar("%", '&buftype') != '' || getwinvar('%', '&previewwindow')
    let modified = &modified
    call s:exec(oldwinnr . "wincmd p")

    "if its a special window e.g. quickfix or another explorer plugin then we
    "have to split
    if specialWindow
        return 0
    endif

    if &hidden
        return 1
    endif

    return !modified || s:bufInWindows(winbufnr(a:winnumber)) >= 2
endfunction

function! s:firstUsableWindow()
    let i = 1
    while i <= winnr("$")
        let bnum = winbufnr(i)
        if bnum != -1 && getbufvar(bnum, '&buftype') ==# ''
                    \ && !getwinvar(i, '&previewwindow')
                    \ && (!getbufvar(bnum, '&modified') || &hidden)
            return i
        endif

        let i += 1
    endwhile
    return -1
endfunction

function! s:openSplit(path)

   " Save the user's settings for splitbelow and splitright
    let savesplitbelow=&splitbelow
    let savesplitright=&splitright

    " 'there' will be set to a command to move from the split window
    " back to the explorer window
    "
    " 'back' will be set to a command to move from the explorer window
    " back to the newly split window
    "
    " 'right' and 'below' will be set to the settings needed for
    " splitbelow and splitright IF the explorer is the only window.
    "
    let there= g:NERDTreeWinPos ==# "left" ? "wincmd h" : "wincmd l"
    let back = g:NERDTreeWinPos ==# "left" ? "wincmd l" : "wincmd h"
    let right= g:NERDTreeWinPos ==# "left"
    let below=0

    " Attempt to go to adjacent window
    call s:exec(back)

    let onlyOneWin = (winnr("$") ==# 1)

    " If no adjacent window, set splitright and splitbelow appropriately
    if onlyOneWin
        let &splitright=right
        let &splitbelow=below
    else
        " found adjacent window - invert split direction
        let &splitright=!right
        let &splitbelow=!below
    endif

    let splitMode = onlyOneWin ? "vertical" : ""

    " Open the new window
    try
        exec(splitMode." sp " . a:path)
    catch /^Vim\%((\a\+)\)\=:E37/
        call s:putCursorInTreeWin()
        throw "Error: ". a:path ." is already open and modified."
    catch /^Vim\%((\a\+)\)\=:/
        "do nothing
    endtry

    "resize the tree window if no other window was open before
    if onlyOneWin
        let size = exists("b:NERDTreeOldWindowSize") ? b:NERDTreeOldWindowSize : g:NERDTreeWinSize
        call s:exec(there)
        exec("silent ". splitMode ." resize ". size)
        call s:exec('wincmd p')
    endif

    " Restore splitmode settings
    let &splitbelow=savesplitbelow
    let &splitright=savesplitright
endfunction

function! s:exec(cmd)
    let old_ei = &ei
    set ei=all
    exec a:cmd
    let &ei = old_ei
endfunction

command!          GitView           call <SID>GitStatus()
