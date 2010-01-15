" MARVIM - MAcro Repository for VIM <marvim.vim>
" Macro and Template saving, lookup and launch script for VIM
"
" Script Info and Documentation  {{{
"=========================================================================
"    Copyright: Copyright (C) 2007 & 2008 Chamindra de Silva 
"      License: GPL v2
" Name Of File: marvim.vim
"  Description: MAcro Repository Vim Plugin
"   Maintainer: Chamindra de Silva <chamindra@gmail.com> 
"          URL: http://chamindra.googlepages.com/marvim 
"  Last Change: 2008 Sep 28 
"      Version: 0.4 Beta
"
"        Usage: 
"
" Installation:
" -------------
" 
" o Download Marvim to your VIM plugin ($VIMRUNTIME/plugin) directory 
"   or source it explicity. Below is an example if you place it in 
"   the home directory
"
"   source $HOME/marvim.vim 
"
" o Start vim and this will automatically create the base marvim macro 
"   repository in your home directory. Based on the OS it will be 
"   located as follows:
"
"   UNIX      ~/.marvim  
"   WINDOWS   C:\Document and Settings\Username\marvim 
"
" o (optional) Copy predefined macro/template directories into the base 
"   marvin macro directory. Marvim uses recursive directory search so 
"   you can nest the directories as you wish.
"
" o (optional) if you want to change the default hotkeys see below
"        
" Hotkeys: 
" --------
" <F2>        - Find and execute a macro or insert template from repository
" Visual <F2> - Replays last macro for each line selected
" <F3>        - Save default macro register by name to the macro repository 
" Visual <F3> - Save selection as template by name to the macro repository 
" <Tab>       - On the Macro command line for cycling through autocomplete
" <Control>+D - On the Macro command line for listing autocomplete options
"
" Usage:
" ------
" o Store a new macro to the repository
" 
" 1)  record macro as usual into q register 
"     (i.e. qq..<macro keystrokes>..q)
" 2)  press save macro key <F3> (default) in normal mode
" 3)  enter the macro name when prompted after the prefix 
"     (a prefix will be provided based on the filetype)
" 4)  macro is now store in the repository
" 
" o Save template into repository
" 
" 1)  select area you want to save in visual mode
" 2)  press the macro save button <F3> (default) in visual mode
" 3)  enter the template name when prompted
"     (a prefix will be provided based on the filetype)
" 4)  template is now saved in repository
" 
" o Recall macro/template through a search
" 
" 1)  press the macro find key <F2> (default) in normal mode
" 2)  enter a search string when prompted 
"     (a prefix will be put by default, which can be deleted)
" 3)  press <tab> or <Control-D> to auto-complete until you find the macro
" 4)  macro is now run and also loaded for further use into the q register
" 
" o Replay last loaded macro on multiple lines for each line
" 
" 1)  select the area you want the macro to run on in visual mode
" 2)  press the macro find key <F3> (default) in visual mode
" 3)  macro in q register is replayed for every line
" 
" Macro Namespace:
" ----------------
" You can organize the macros by a namespace. To save a macro in the name
" space X, simply us X:macro_name when saving the macro. This will create
" a subdirectory called X in your mavim repository as save this macro there
" You can also create namespaces by putting a collection of macros in a
" subdirectory of the mavim repository. This will permit you to organize
" your macros accordingly
"
" Changing the default hotkeys, repository and macro register:
" ------------------------------------------------------------
" Optionally place the following lines in your vimrc before the location 
" you source the marvim.vim script (don't worry about location if 
" the script is in the vim plugin directory). 
"
"   " to change the macro storage location use the following 
"   let marvim_store = '/usr/local/share/projectX/marvim' 
"   let marvim_find_key = '<Space>' " change find key from <F2> to 'space'
"   let marvim_store_key = 'ms'     " change store key from <F3> to 'ms'
"   let marvim_register = 'c'       " change used register from 'q' to 'c'
"   let marvim_prefix = 0           " disable default syntax based prefix
"
"   source $HOME/marvim.vim   " omit if marvim.vim is in the plugin dir
"
" Tips:
" -----
"  o <Space> can be very effective as the macro find key
"  o use the namespaces to organize a directory for each language
"  o use a naming convention for your macros to make it easy to find. e.g.:
"
"    php:if-block
"    php:strip-tags
"    php:mysql-select-block
"    php:mysql-update-block
" 
"  o if multiple people are working on the same project, consider a shared
"    marvim store to share templates and macros to improve team
"    productivity
"
"  o share your marvim marco stores with each other and also with the
"    central repository at http://chamindra.googlepages.com/marvim
"
" Bugs, Patches, Help and Suggestions:
" ------------------------------------
" If you find any bugs, have new patches or need some help, please send
" and email to chamindra [at] opensource.lk and put the word marvim in the
" subject line. Also we welcome you to share your repositories.
"
" Freeze? I'm a robot, not a refrigerator" - Marvin the Paranoid Android
" http://chamindra.googlepages.com/marvim
"
" Change Log:
" -----------
" v0.4
" - Now supports autocompletion when searching for macros
" - The filetype gives the default namespace for storage and retrival
" - Refactoring of functions for namespace to directory mappings
" v0.3
" - New namespace features for macro that map to macro sub-directories
" - Supported the creation of macros and templates in a namespace
" - Creates namespace directories if they do not exist
" - Added the ability to point to a different macro store
" - The above permits a shared macro/template repository within a team
" - Refactored code to make macro and template saving a function
" - Fixed bug on windows listing of macros without whole path name
" v0.2
" - Made script windows compatible
" - Makes the macro home directory if it does not exist
" - Recursively looks up base repository subdirectories for macros
" - Creates a macro menu for the GUI versions
" - Changed defauly macro input register to q
" - Made it easy to define configuration details in vimrc
" - Abstracted hotkeys so that they can be defined in the vimrc easily
" - Fixed the breaking on spaces in directory paths
" - Changed template extension to mvt for ease
" - Changed naming conventions to avoid namespace conflict
" v0.1
" - Platform independant script (almost ;-)
" - recording of vim version with macro 
" - redefinition of macro_home and macro_register
"
" Todo
" - check vim version number when running macro
"
"=============================================================================
" }}}

" check if script is loaded already or if the user does not want it loaded
if exists("loaded_marvim")
	finish
endif
let loaded_marvim = 1

" define hotkeys if they have not been defined in the vimrc
if !exists('marvim_register')
    let g:marvim_register = 'q'  
endif

if !exists('marvim_find_key')
    let g:marvim_find_key = '<F2>'
endif

if !exists('marvim_store_key')
    let g:marvim_store_key = '<F3>'
endif

if !exists('marvim_prefix')
    let g:marvim_prefix = 1 
endif


" Define all mappings to functions provided keys are available
" Define all mappings to functions provided keys are available
"
" if mapcheck(g:marvim_store_key) == "" && mapcheck(g:marvim_find_key) == "" 
    exec 'nnoremap '.g:marvim_store_key.' :call Marvim_macro_store()<CR>'
    "exec 'nnoremap '.g:marvim_store_key.' :call Marvim_template_store()<CR>'
    exec 'vnoremap '.g:marvim_store_key.' y:call Marvim_template_store()<CR>'
    exec 'nnoremap '.g:marvim_find_key.' :call Marvim_search()<CR>'
    exec 'vnoremap '.g:marvim_find_key.' :norm@'.g:marvim_register.'<CR>' 
" endif

    "exec 'vnoremap '.g:marvim_store_key.' :<C-U>call Marvim_visual_template_store()<CR>'

if has('menu')
    menu &Macro.&Find :call Marvim_search()<CR>
    nmenu &Macro.&Store\ Macro :call Marvim_macro_store()<CR>
    vmenu &Macro.&Store\ Template y:call Marvim_template_store()<CR>
    nmenu &Macro.&Store\ Template :call Marvim_template_store()<CR>
endif

" OS Specific configuration 
if has('win16') || has('win32') || has ('win95') || has('win64')
    let s:macro_home = $HOME.'\marvim\' " under your documents and settings 
    let s:path_seperator = '\'
else " assume UNIX based
    let s:macro_home = $HOME."/.marvim/"
    let s:path_seperator = '/'
endif

" set the marvim store to a different location if sepcified by user
if exists('marvim_store')
    if g:marvim_store[-1:] != s:path_seperator
        " add a trailing directory slash if it does not exist  
        let s:macro_home = g:marvim_store.s:path_seperator
    else
        let s:macro_home = g:marvim_store
    endif
endif

" create the repository directory if it does not exist
if !isdirectory(s:macro_home)
    " need to strip end slash before call the mkdir function
    call mkdir(strpart(s:macro_home, 0 , strlen(s:macro_home)-1), "p")
endif

let s:vim_ver = strpart(v:version,0,1) " get the major vim version number
let s:ext = '.mv'.s:vim_ver  " specify macro extension by vim version number
let s:text = '.mvt' " template extension

" The input function with a namespace prefix
function! Marvim_input(prompt)
    
    " use a default prefix by filetype unless it has been disabled
    if ( &filetype == '' || !g:marvim_prefix )
        let l:namespace = ''
    else
        let l:namespace = &filetype.':'
    endif

    " get the input with custom autocompletion
    let l:tmp = input(a:prompt, l:namespace, "customlist,Marvim_completion")

    return l:tmp

endfunction

" custom completion function for Marvim_input()
function! Marvim_completion(ArgLead, CmdLine, CursorPos)

    let l:c_list = []  " initialize list
    let l:tmp = tr(a:ArgLead, ":", s:path_seperator)
    let l:search_dir = Marvim_get_directory(s:macro_home.l:tmp)
    let l:search_string = Marvim_get_filename(s:macro_home.l:tmp)

    " recursively search in the namespace directory to get all files
    let l:search_list = glob(l:search_dir.s:path_seperator.'**') 
 
    let l:asearch_list = split(l:search_list, '\n')  

    " filter by the macro extension .mv?
    let l:macro_list = filter(l:asearch_list, 'v:val =~ ".mv"')
 
    " translate each item to the namespace version 
    let l:item_count = 0
    for l:item in l:macro_list

        let l:item_count = l:item_count + 1

        " get the filename
        let l:file_split = strpart(l:item, strlen(s:macro_home))
        let l:filename = tr(l:file_split, s:path_seperator, ":")

        " remove trailing extension TODO: can break on multiple .
        let l:name_split = split (l:filename, '\.') 

        " add the item to the complete list 
        call add(l:c_list, l:name_split[0]) 

    endfor 

    " filter namespace list on postfix search string
    let l:complete_list = filter(l:c_list, 'v:val =~ "'.l:search_string.'"')

    return l:complete_list

endfunction

" template save in visual mode
function! Marvim_template_store()

    " yank the visual block into the default register
    " if previous command was not visual this is ignored
    " allowing for other forms of yanking
    " silent execute 'normal! `<v`>y<CR>'  

    let l:listtmp = split(@@,'\n') " get default yank buffer
    let l:template_name = Marvim_input('Enter Template Save Name -> ') 

    call Marvim_file_save(l:template_name, l:listtmp, s:text)
    
    echo 'Template '.l:template_name.' Stored'

endfunction

" hotkey mapping dynamic input function for Marvim_file_save
function! Marvim_macro_store()

    let l:macro_name = Marvim_input('Enter Macro Save Name -> ') 

    "let l:listtmp = [@c] " get the macro from register c
    let l:listtmp = [getreg(g:marvim_register)]

    call Marvim_file_save(l:macro_name, l:listtmp, s:ext)
    " clear the command line
    echo 'Macro '.l:macro_name.' Stored'

endfunction

" Get the directory name of the fill file path without last slash
function! Marvim_get_directory(fullfilename)

    let l:lastslash = strridx(a:fullfilename, s:path_seperator)

    let l:dirname = strpart( a:fullfilename, 0, l:lastslash)

    return l:dirname

endfunction

" Get the file name from the directory path 
function! Marvim_get_filename(fullfilename)

    let l:lastslash = strridx(a:fullfilename, s:path_seperator)

    let l:filename = strpart( a:fullfilename, l:lastslash+1)

    return l:filename

endfunction

" return the fullfilename from the macro name e.g. php:deletebrackets
function! Marvim_ns_to_filename(macro_name)

    let l:name = tr(a:macro_name, ":", s:path_seperator)

    let l:prefix = s:macro_home.l:name

    let l:fullfilename = glob(l:prefix.".mv?")
   
    return l:fullfilename

endfunction

" The macro save function
function! Marvim_file_save(macro_name, data, exttype)

    let l:name = tr(a:macro_name, ":", s:path_seperator)

    let l:fullfilename = s:macro_home.l:name.a:exttype

    let l:dirname = Marvim_get_directory(l:fullfilename)

    if !isdirectory(l:dirname) 

        call mkdir (l:dirname, "p")

    endif

    if ( a:exttype == s:ext ) " if this is a macro

        call writefile(a:data, l:fullfilename, 'b')

    else " else if it a template

        call writefile(a:data, l:fullfilename)
    endif

endfunction

" Run the macro file
" @param macro_file - full path to the macro file
function! Marvim_file_run(macro_file)

    " If the file does not exist or is not readable return
    let l:isMacro = filereadable(a:macro_file)
    if ( l:isMacro == 0 )
        echo 'Macro does not exist'
        return
    endif

    " find if it is a template or a macro
    let l:t = split(a:macro_file, '\.')
    let s:macro_type = l:t[-1] " get the extension

    if s:macro_type == s:text[1:]  " 'mvt' read template 

        silent execute 'read '.a:macro_file

    else  " a vim macro
        " execute 'so! '.s:macro_home.a:macro_name.s:ext
        
        " read the macro file into the register and run it
        let l:macro_content = readfile(a:macro_file,'b')
        call setreg(g:marvim_register,l:macro_content[0]) 
        silent execute 'normal @'.g:marvim_register
        "echo 'Ran Macro '.a:macro_file

    endif

endfunction

" Macro Search function
function! Marvim_search()

    let l:macro_name = Marvim_input('Macro Search -> ')

    if (l:macro_name != '')

        let l:macro_file = Marvim_ns_to_filename(l:macro_name)

        call Marvim_file_run(l:macro_file)

        echo 'Macro '.l:macro_name.' Run'

    endif

endfunction

