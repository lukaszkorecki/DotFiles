""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cakephp.vim
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "
" " Last Change:  05-Oct-2009.
" " Author:       Kota Sakoda <cohtan AT cpan DOT org>
" " Forker:       Łukasz Korecki <lukasz AT coffeesounds DOT com
" " Version:      0.000002.1
" " Licence:      MIT Licence
" " URL:          http://trac.codecheck.in/
" "
" "-----------------------------------------------------------------------------
"
" jump to files commands"
" TODO make use of the ConvPlural function
function! s:CakeRunner(action,...)
	echo " " . a:action . "" 
	echo "" . s:action . ""
endfunction
function! s:JumpToController(arg)
    execute 'chdir ' . g:Cake_Dir
    let open_command = "e " . g:Cake_Dir . "/controllers/" . a:arg . "_controller.php"
    execute open_command
endfunction
" requires actual model name i.e. user not users"
function! s:JumpToModel(arg)
    execute 'chdir ' . g:Cake_Dir
    let open_command = "e " . g:Cake_Dir . "/models/" . a:arg . ".php"
    execute open_command
endfunction
"open (or create) new view using a path, for example :JumpToView users/add"
function! s:JumpToView(arg) 
    execute 'chdir ' . g:Cake_Dir
    let open_command = "e " . g:Cake_Dir . "/views/" . a:arg . ".ctp"
    execute open_command
endfunction

function! s:JumpCakeAppController()
    execute 'chdir ' . g:Cake_Dir
    let open_command = "e " . g:Cake_Dir . "/app_controller.php"
    execute open_command
endfunction
function! s:SetCakeDir(path)
	let g:Cake_Dir = path
endfunction
function! s:SetCdCakeDir()
	let g:Cake_Dir = getcwd()
endfunction

function! s:Ccontroller()
    execute 'chdir ' . g:Cake_Dir
    let s:Filename = substitute(bufname(""), g:Cake_Dir, "", "")
    " Controllerからきた場合は終了
    if s:Filename =~ "_controller\.php$"
        return
    endif
    " Viewからの場合
    if s:Filename =~ "views"
        let dname  = substitute(s:Filename, "views/", "", "g")
        let bclass = substitute(dname, '/.*', "", "g")
        let dfile  = substitute(dname, '.*/', "", "g")
        let dfile  = substitute(dfile, '\.ctp', '', 'g')

        let open_command = "e " . g:Cake_Dir . "/controllers/" . bclass . "_controller.php"
        echo open_command
        echo dfile
        exec open_command
        call search('function ' .  dfile)
    endif
    " Modelからの場合
    if s:Filename =~ "models"
        let dname  = substitute(s:Filename, g:Cake_Dir, "", "")
        let fname  = substitute(dname, '\(/\|models\)', "", "gi")
        let bclass = substitute(fname, '\.php', "", "g")

        echo dname
        echo fname
        echo bclass
        " とりあえず単数形を複数系に
        let bclass = s:ConvPlural(bclass)
        let open_command = "e " . g:Cake_Dir . "/controllers/" . bclass . "_controller.php"
        echo open_command
        exec open_command
    endif
endfunction

function! s:Cmodel()
    execute 'chdir ' . g:Cake_Dir
    let s:Filename = substitute(bufname(""), g:Cake_Dir, "", "")
    " Controllerからの場合
    if s:Filename =~ "controllers"
        let dname  = substitute(s:Filename, g:Cake_Dir, "", "")
        let fname  = substitute(dname, '\(/\|controllers\)', "", "gi")
        let bclass = substitute(fname, '_controller.php', "", "g")
        " 複数形から単数形へ
        let bclass = s:ConvSingular(bclass)
        let open_command = "e " . g:Cake_Dir . "/models/" . bclass . ".php"
        echo open_command
        exec open_command
        return 
    endif
    " Viewからの場合
    if s:Filename =~ "views"
        let dname = substitute(s:Filename, "views/", "", "g")
        let bclass = substitute(dname, '/.*', "", "g")
        " とりあえず複数形を単数系に
        let bclass = s:ConvSingular(bclass)
        echo bclass
        let open_command = "e " . g:Cake_Dir . "/models/" . bclass . ".php"
        echo open_command
        exec open_command
    endif
    return 
endfunction

function! s:Cview()
    execute 'chdir ' . g:Cake_Dir
    let s:Filename = substitute(bufname(""), g:Cake_Dir, "", "")
    " Controllerからの場合
    if s:Filename =~ "controllers"
        let dname  = substitute(s:Filename, g:Cake_Dir, "", "")
        let fname  = substitute(dname, '\(/\|controllers\)', "", "gi")
        let bclass = substitute(fname, '_controller.php', "", "g")
        " 対象のViewファイルを探す
        " functionを逆に検索してみる
        call search('function', 'b')
        execute "normal wvf(hy"
        let s:View = getreg()
        let open_command = "e " . g:Cake_Dir . "/views/" . bclass . '/' . s:View . ".ctp"
        echo open_command
        exec open_command
    endif
    " Modelからの場合は無理っちゃ無理か
endfunction

" javascript->linkの中身を開く
function! s:Cjavascript()
    execute 'chdir ' . g:Cake_Dir
    execute "normal ^"
    execute "normal f(vi'y"
    let s:Js = getreg()
    if s:Js !~ '^.*\.js$'
        call inputsave()
        let s:Js = input("input JS file name:")
        call inputrestore()
        if s:Js !~ '^.*\.js$'
            let s:Js = s:Js . ".js"
        endif
    endif
    echo s:Js
    let open_command = "e " . g:Cake_Dir . "/webroot/js/" . s:Js
    exec open_command
endfunction


function! s:ConvPlural(var)
    let t = a:var

    let corePluralRules = { '\(s\)tatus$' :  '\1\2tatuses',
\       '\(quiz\)$' :  '\1zes',
\       '^\(ox\)$' :  '\1\2en',
\       '\([m\|l]\)ouse$' :  '\1ice',
\       '\(matr\|vert\|ind\)\(ix\|ex\)$'  :  '\1ices',
\       '\(x\|ch\|ss\|sh\)$' :  '\1es',
\       '\([^aeiouy]\|qu\)y$' :  '\1ies',
\       '\(hive\)$' :  '\1s',
\       '\(?:\([^f]\)fe\|\([lr]\)f\)$' :  '\1\2ves',
\       'sis$' :  'ses',
\       '\([ti]\)um$' :  '\1a',
\       '\(p\)erson$' :  '\1eople',
\       '\(m\)an$' :  '\1en',
\       '\(c\)hild$' :  '\1hildren',
\       '\(buffal\|tomat\)o$' :  '\1\2oes',
\       '\(alumn\|bacill\|cact\|foc\|fung\|nucle\|radi\|stimul\|syllab\|termin\|vir\)us$' :  '\1i',
\       'us$g' :  'uses',
\       '\(alias\)$' :  '\1es',
\       '\(ax\|cri\|test\)is$' :  '\1es',
\       's$' :  's',
\       '$' :  's' }

    let coreUninflectedPlural = ['.*[nrlm]ese', '.*deer', '.*fish', '.*measles', '.*ois', '.*pox', '.*sheep', 'Amoyese',
\       'bison', 'Borghese', 'bream', 'breeches', 'britches', 'buffalo', 'cantus', 'carp', 'chassis', 'clippers',
\       'cod', 'coitus', 'Congoese', 'contretemps', 'corps', 'debris', 'diabetes', 'djinn', 'eland', 'elk',
\       'equipment', 'Faroese', 'flounder', 'Foochowese', 'gallows', 'Genevese', 'Genoese', 'Gilbertese', 'graffiti',
\       'headquarters', 'herpes', 'hijinks', 'Hottentotese', 'information', 'innings', 'jackanapes', 'Kiplingese',
\       'Kongoese', 'Lucchese', 'mackerel', 'Maltese', 'media', 'mews', 'moose', 'mumps', 'Nankingese', 'news',
\       'nexus', 'Niasese', 'Pekingese', 'Piedmontese', 'pincers', 'Pistoiese', 'pliers', 'Portuguese', 'proceedings',
\       'rabies', 'rice', 'rhinoceros', 'salmon', 'Sarawakese', 'scissors', 'sea[- ]bass', 'series', 'Shavese', 'shears',
\       'siemens', 'species', 'swine', 'testes', 'trousers', 'trout', 'tuna', 'Vermontese', 'Wenchowese',
\       'whiting', 'wildebeest', 'Yengeese']

    let coreIrregularPlural = { 'atlas' : 'atlases',
\       'beef' : 'beefs',
\       'brother' : 'brothers',
\       'child' : 'children',
\       'corpus' : 'corpuses',
\       'cow' : 'cows',
\       'ganglion' : 'ganglions',
\       'genie' : 'genies',
\       'genus' : 'genera',
\       'graffito' : 'graffiti',
\       'hoof' : 'hoofs',
\       'loaf' : 'loaves',
\       'man' : 'men',
\       'money' : 'monies',
\       'mongoose' : 'mongooses',
\       'move' : 'moves',
\       'mythos' : 'mythoi',
\       'numen' : 'numina',
\       'occiput' : 'occiputs',
\       'octopus' : 'octopuses',
\       'opus' : 'opuses',
\       'ox' : 'oxen',
\       'penis' : 'penises',
\       'person' : 'people',
\       'sex' : 'sexes',
\       'soliloquy' : 'soliloquies',
\       'testis' : 'testes',
\       'trilby' : 'trilbys',
\       'turf' : 'turfs' }

    let lastval = ''
    " イレギュラーなものは省く

    if lastval == ''
        for key in coreUninflectedPlural
            if t =~ key
                let lastval = t
                break
            endif
        endfor
    endif 

    if lastval == ''
        for key in keys(coreIrregularPlural)
            if t =~ key
                let lastval = substitute(t, key, coreIrregularPlural[key], 'gi')
                break
            endif 
        endfor
    endif

    if lastval == ''
        for key in keys(corePluralRules)
            if t =~ key
                let lastval = substitute(t, key, corePluralRules[key], 'gi')
                break
            endif 
        endfor
    endif

    return lastval
endfunction

function! s:ConvSingular(var)
    let t = a:var

    let coreSingularRules = {'\(s\)tatuses$' : '\1\2tatus',
\       '^\(.*\)\(menu\)s$' : '\1\2',
\       '\(quiz\)zes$' : '\1',
\       '\(matr\)ices$' : '\1ix',
\       '\(vert\|ind\)ices$' : '\1ex',
\       '^\(ox\)en' : '\1',
\       '\(alias\)\(es\)*$' : '\1',
\       '\(alumn\|bacill\|cact\|foc\|fung\|nucle\|radi\|stimul\|syllab\|termin\|viri?\)i$' : '\1us',
\       '\(cris\|ax\|test\)es$' : '\1is',
\       '\(shoe\)s$' : '\1',
\       '\(o\)es$' : '\1',
\       'ouses$' : 'ouse',
\       'uses$' : 'us',
\       '\([m\|l]\)ice$' : '\1ouse',
\       '\(x\|ch\|ss\|sh\)es$' : '\1',
\       '\(m\)ovies$' : '\1\2ovie',
\       '\(s\)eries$' : '\1\2eries',
\       '\([^aeiouy]\|qu\)ies$' : '\1y',
\       '\([lr]\)ves$' : '\1f',
\       '\(tive\)s$' : '\1',
\       '\(hive\)s$' : '\1',
\       '\(drive\)s$' : '\1',
\       '\([^f]\)ves$' : '\1fe',
\       '\(^analy\)ses$' : '\1sis',
\       '\(\(a\)naly\|\(b\)a\|\(d\)iagno\|\(p\)arenthe\|\(p\)rogno\|\(s\)ynop\|\(t\)he\)ses$' : '\1\2sis',
\       '\([ti]\)a$' : '\1um',
\       '\(p\)eople$' : '\1\2erson',
\       '\(m\)en$' : '\1an',
\       '\(c\)hildren$' : '\1\2hild',
\       '\(n\)ews$' : '\1\2ews',
\       '^\(.*us\)$' : '\1',
\       's$' : ''}

    let coreUninflectedSingular = ['.*[nrlm]ese', '.*deer', '.*fish', '.*measles', '.*ois', '.*pox', '.*sheep', '.*ss', 'Amoyese',
\       'bison', 'Borghese', 'bream', 'breeches', 'britches', 'buffalo', 'cantus', 'carp', 'chassis', 'clippers',
\       'cod', 'coitus', 'Congoese', 'contretemps', 'corps', 'debris', 'diabetes', 'djinn', 'eland', 'elk',
\       'equipment', 'Faroese', 'flounder', 'Foochowese', 'gallows', 'Genevese', 'Genoese', 'Gilbertese', 'graffiti',
\       'headquarters', 'herpes', 'hijinks', 'Hottentotese', 'information', 'innings', 'jackanapes', 'Kiplingese',
\       'Kongoese', 'Lucchese', 'mackerel', 'Maltese', 'media', 'mews', 'moose', 'mumps', 'Nankingese', 'news',
\       'nexus', 'Niasese', 'Pekingese', 'Piedmontese', 'pincers', 'Pistoiese', 'pliers', 'Portuguese', 'proceedings',
\       'rabies', 'rice', 'rhinoceros', 'salmon', 'Sarawakese', 'scissors', 'sea[- ]bass', 'series', 'Shavese', 'shears',
\       'siemens', 'species', 'swine', 'testes', 'trousers', 'trout', 'tuna', 'Vermontese', 'Wenchowese',
\       'whiting', 'wildebeest', 'Yengeese']

    let coreIrregularSingular = {'atlases' : 'atlas',
\       'beefs' : 'beef',
\       'brothers' : 'brother',
\       'children' : 'child',
\       'corpuses' : 'corpus',
\       'cows' : 'cow',
\       'ganglions' : 'ganglion',
\       'genies' : 'genie',
\       'genera' : 'genus',
\       'graffiti' : 'graffito',
\       'hoofs' : 'hoof',
\       'loaves' : 'loaf',
\       'men' : 'man',
\       'monies' : 'money',
\       'mongooses' : 'mongoose',
\       'moves' : 'move',
\       'mythoi' : 'mythos',
\       'numina' : 'numen',
\       'occiputs' : 'occiput',
\       'octopuses' : 'octopus',
\       'opuses' : 'opus',
\       'oxen' : 'ox',
\       'penises' : 'penis',
\       'people' : 'person',
\       'sexes' : 'sex',
\       'soliloquies' : 'soliloquy',
\       'testes' : 'testis',
\       'trilbys' : 'trilby',
\       'turfs' : 'turf'}

    let lastval = ''
    " イレギュラーなものは省く

    if lastval == ''
        for key in coreUninflectedSingular
            if t =~ key
                let lastval = t
                break
            endif
        endfor
    endif 

    if lastval == ''
        for key in keys(coreIrregularSingular)
            if t =~ key
                let lastval = substitute(t, key, coreIrregularSingular[key], 'gi')
                break
            endif 
        endfor
    endif

    if lastval == ''
        for key in keys(coreSingularRules)
            if t =~ key
                let lastval = substitute(t, key, coreSingularRules[key], 'gi')
                break
            endif 
        endfor
    endif

    if lastval == ''
        let lastval = t
    endif

    return lastval

endfunction


command! -bar -narg=0 Cakecontroller call s:Ccontroller()
command! -bar -narg=0 Cakemodel call s:Cmodel()
command! -bar -narg=0 Cakeview call s:Cview()
command! -bar -narg=0 Cakejavascript call s:Cjavascript()

command! -bar -narg=1 JCakecontroller call s:JumpToController('<args>')
command! -bar -narg=1 JCakemodel call s:JumpToModel('<args>')
command! -bar -narg=1 JCakeview call s:JumpToView('<args>')

command! -bar -narg=0 CakeAppController call s:JumpCakeAppController()

command! -bar -narg=0 CakeCurrentPath call s:SetCdCakeDir()

command! -bar -narg=1 CakeSetPath call s:SetCakeDir('<args>')
command! -bar -narg=* Cake call s:CakeRunner('<args>')
