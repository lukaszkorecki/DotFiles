" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
autoload/rubycomplete.vim
802
" Vim completion script
" Language:             Ruby
" Maintainer:           Mark Guzman <segfault@hasno.info>
" Info:                 $Id: rubycomplete.vim,v 1.39 2006/12/13 21:20:47 segy Exp $
" URL:                  http://vim-ruby.rubyforge.org
" Anon CVS:             See above site
" Release Coordinator:  Doug Kearns <dougkearns@gmail.com>
" Maintainer Version:   0.8
" ----------------------------------------------------------------------------
"
" Ruby IRB/Complete author: Keiju ISHITSUKA(keiju@ishitsuka.com)
" ----------------------------------------------------------------------------

" {{{ requirement checks
if !has('ruby')
    s:ErrMsg( "Error: Rubycomplete requires vim compiled with +ruby" )
    s:ErrMsg( "Error: falling back to syntax completion" )
    " lets fall back to syntax completion
    setlocal omnifunc=syntaxcomplete#Complete
    finish
endif

if version < 700
    s:ErrMsg( "Error: Required vim >= 7.0" )
    finish
endif
" }}} requirement checks

" {{{ configuration failsafe initialization
if !exists("g:rubycomplete_rails")
    let g:rubycomplete_rails = 0
endif

if !exists("g:rubycomplete_classes_in_global")
    let g:rubycomplete_classes_in_global = 0
endif

if !exists("g:rubycomplete_buffer_loading")
    let g:rubycomplete_classes_in_global = 0
endif

if !exists("g:rubycomplete_include_object")
    let g:rubycomplete_include_object = 0
endif

if !exists("g:rubycomplete_include_objectspace")
    let g:rubycomplete_include_objectspace = 0
endif
" }}} configuration failsafe initialization

" {{{ vim-side support functions
let s:rubycomplete_debug = 0

function! s:ErrMsg(msg)
    echohl ErrorMsg
    echo a:msg
    echohl None
endfunction

function! s:dprint(msg)
    if s:rubycomplete_debug == 1
        echom a:msg
    endif
endfunction

function! s:GetBufferRubyModule(name, ...)
    if a:0 == 1
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "module", a:1)
    else
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "module")
    endif
    return snum . '..' . enum
endfunction

function! s:GetBufferRubyClass(name, ...)
    if a:0 >= 1
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "class", a:1)
    else
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "class")
    endif
    return snum . '..' . enum
endfunction

function! s:GetBufferRubySingletonMethods(name)
endfunction

function! s:GetBufferRubyEntity( name, type, ... )
    let lastpos = getpos(".")
    let lastline = lastpos
    if (a:0 >= 1)
        let lastline = [ 0, a:1, 0, 0 ]
        call cursor( a:1, 0 )
    endif

    let stopline = 1

    let crex = '^\s*\<' . a:type . '\>\s*\<' . a:name . '\>\s*\(<\s*.*\s*\)\?'
    let [lnum,lcol] = searchpos( crex, 'w' )
    "let [lnum,lcol] = searchpairpos( crex . '\zs', '', '\(end\|}\)', 'w' )

    if lnum == 0 && lcol == 0
        call cursor(lastpos[1], lastpos[2])
        return [0,0]
    endif

    let curpos = getpos(".")
    let [enum,ecol] = searchpairpos( crex, '', '\(end\|}\)', 'wr' )
    call cursor(lastpos[1], lastpos[2])

    if lnum > enum
        return [0,0]
    endif
    " we found a the class def
    return [lnum,enum]
endfunction

function! s:IsInClassDef()
    return s:IsPosInClassDef( line('.') )
endfunction

function! s:IsPosInClassDef(pos)
    let [snum,enum] = s:GetBufferRubyEntity( '.*', "class" )
    let ret = 'nil'

    if snum < a:pos && a:pos < enum
        let ret = snum . '..' . enum
    endif

    return ret
endfunction

function! s:GetRubyVarType(v)
    let stopline = 1
    let vtp = ''
    let pos = getpos('.')
    let sstr = '^\s*#\s*@var\s*'.a:v.'\>\s\+[^ \t]\+\s*$'
    let [lnum,lcol] = searchpos(sstr,'nb',stopline)
    if lnum != 0 && lcol != 0
        call setpos('.',pos)
        let str = getline(lnum)
        let vtp = substitute(str,sstr,'\1','')
        return vtp
    endif
    call setpos('.',pos)
    let ctors = '\(now\|new\|open\|get_instance'
    if exists('g:rubycomplete_rails') && g:rubycomplete_rails == 1 && s:rubycomplete_rails_loaded == 1
        let ctors = ctors.'\|find\|create'
    else
    endif
    let ctors = ctors.'\)'

    let fstr = '=\s*\([^ \t]\+.' . ctors .'\>\|[\[{"''/]\|%[xwQqr][(\[{@]\|[A-Za-z0-9@:\-()\.]\+...\?\|lambda\|&\)'
    let sstr = ''.a:v.'\>\s*[+\-*/]*'.fstr
    let [lnum,lcol] = searchpos(sstr,'nb',stopline)
    if lnum != 0 && lcol != 0
        let str = matchstr(getline(lnum),fstr,lcol)
        let str = substitute(str,'^=\s*','','')

        call setpos('.',pos)
        if str == '"' || str == '''' || stridx(tolower(str), '%q[') != -1
            return 'String'
        elseif str == '[' || stridx(str, '%w[') != -1
            return 'Array'
        elseif str == '{'
            return 'Hash'
        elseif str == '/' || str == '%r{'
            return 'Regexp'
        elseif strlen(str) >= 4 && stridx(str,'..') != -1
            return 'Range'
        elseif stridx(str, 'lambda') != -1 || str == '&'
            return 'Proc'
        elseif strlen(str) > 4
            let l = stridx(str,'.')
            return str[0:l-1]
        end
        return ''
    endif
    call setpos('.',pos)
    return ''
endfunction

"}}} vim-side support functions

"{{{ vim-side completion function
function! rubycomplete#Init()
    execute "ruby VimRubyCompletion.preload_rails"
endfunction

function! rubycomplete#Complete(findstart, base)
     "findstart = 1 when we need to get the text length
    if a:findstart
        let line = getline('.')
        let idx = col('.')
        while idx > 0
            let idx -= 1
            let c = line[idx-1]
            if c =~ '\w'
                continue
            elseif ! c =~ '\.'
                idx = -1
                break
            else
                break
            endif
        endwhile

        return idx
    "findstart = 0 when we need to return the list of completions
    else
        let g:rubycomplete_completions = []
        execute "ruby VimRubyCompletion.get_completions('" . a:base . "')"
        return g:rubycomplete_completions
    endif
endfunction
"}}} vim-side completion function

"{{{ ruby-side code
function! s:DefRuby()
ruby << RUBYEOF
# {{{ ruby completion

begin
    require 'rubygems' # let's assume this is safe...?
rescue Exception
    #ignore?
end
class VimRubyCompletion
# {{{ constants
  @@debug = false
  @@ReservedWords = [
        "BEGIN", "END",
        "alias", "and",
        "begin", "break",
        "case", "class",
        "def", "defined", "do",
        "else", "elsif", "end", "ensure",
        "false", "for",
        "if", "in",
        "module",
        "next", "nil", "not",
        "or",
        "redo", "rescue", "retry", "return",
        "self", "super",
        "then", "true",
        "undef", "unless", "until",
        "when", "while",
        "yield",
      ]

  @@Operators = [ "%", "&", "*", "**", "+",  "-",  "/",
        "<", "<<", "<=", "<=>", "==", "===", "=~", ">", ">=", ">>",
        "[]", "[]=", "^", ]
# }}} constants

# {{{ buffer analysis magic
  def load_requires
    buf = VIM::Buffer.current
    enum = buf.line_number
    nums = Range.new( 1, enum )
    nums.each do |x|
      ln = buf[x]
      begin
        eval( "require %s" % $1 ) if /.*require\s*(.*)$/.match( ln )
      rescue Exception
        #ignore?
      end
    end
  end

  def load_buffer_class(name)
    dprint "load_buffer_class(%s) START" % name
    classdef = get_buffer_entity(name, 's:GetBufferRubyClass("%s")')
    return if classdef == nil

    pare = /^\s*class\s*(.*)\s*<\s*(.*)\s*\n/.match( classdef )
    load_buffer_class( $2 ) if pare != nil  && $2 != name # load parent class if needed

    mixre = /.*\n\s*include\s*(.*)\s*\n/.match( classdef )
    load_buffer_module( $2 ) if mixre != nil && $2 != name # load mixins if needed

    begin
      eval classdef
    rescue Exception
      VIM::evaluate( "s:ErrMsg( 'Problem loading class \"%s\", was it already completed?' )" % name )
    end
    dprint "load_buffer_class(%s) END" % name
  end

  def load_buffer_module(name)
    dprint "load_buffer_module(%s) START" % name
    classdef = get_buffer_entity(name, 's:GetBufferRubyModule("%s")')
    return if classdef == nil

    begin
      eval classdef
    rescue Exception
      VIM::evaluate( "s:ErrMsg( 'Problem loading module \"%s\", was it already completed?' )" % name )
    end
    dprint "load_buffer_module(%s) END" % name
  end

  def get_buffer_entity(name, vimfun)
    loading_allowed = VIM::evaluate("exists('g:rubycomplete_buffer_loading') && g:rubycomplete_buffer_loading")
    return nil if loading_allowed != '1'
    return nil if /(\"|\')+/.match( name )
    buf = VIM::Buffer.current
    nums = eval( VIM::evaluate( vimfun % name ) )
    return nil if nums == nil
    return nil if nums.min == nums.max && nums.min == 0

    dprint "get_buffer_entity START"
    visited = []
    clscnt = 0
    bufname = VIM::Buffer.current.name
    classdef = ""
    cur_line = VIM::Buffer.current.line_number
    while (nums != nil && !(nums.min == 0 && nums.max == 0) )
      dprint "visited: %s" % visited.to_s
      break if visited.index( nums )
      visited << nums

      nums.each do |x|
        if x != cur_line
          next if x == 0
          ln = buf[x]
          if /^\s*(module|class|def|include)\s+/.match(ln)
            clscnt += 1 if $1 == "class"
            #dprint "\$1: %s" % $1
            classdef += "%s\n" % ln
            classdef += "end\n" if /def\s+/.match(ln)
            dprint ln
          end
        end
      end

      nm = "%s(::.*)*\", %s, \"" % [ name, nums.last ]
      nums = eval( VIM::evaluate( vimfun % nm ) )
      dprint "nm: \"%s\"" % nm
      dprint "vimfun: %s" % (vimfun % nm)
      dprint "got nums: %s" % nums.to_s
    end
    if classdef.length > 1
        classdef += "end\n"*clscnt
        # classdef = "class %s\n%s\nend\n" % [ bufname.gsub( /\/|\\/, "_" ), classdef ]
    end

    dprint "get_buffer_entity END"
    dprint "classdef====start"
    lns = classdef.split( "\n" )
    lns.each { |x| dprint x }
    dprint "classdef====end"
    return classdef
  end

  def get_var_type( receiver )
    if /(\"|\')+/.match( receiver )
      "String"
    else
      VIM::evaluate("s:GetRubyVarType('%s')" % receiver)
    end
  end

  def dprint( txt )
    print txt if @@debug
  end

  def get_buffer_entity_list( type )
    # this will be a little expensive.
    loading_allowed = VIM::evaluate("exists('g:rubycomplete_buffer_loading') && g:rubycomplete_buffer_loading")
    allow_aggressive_load = VIM::evaluate("exists('g:rubycomplete_classes_in_global') && g:rubycomplete_classes_in_global")
    return [] if allow_aggressive_load != '1' || loading_allowed != '1'

    buf = VIM::Buffer.current
    eob = buf.length
    ret = []
    rg = 1..eob
    re = eval( "/^\s*%s\s*([A-Za-z0-9_:-]*)(\s*<\s*([A-Za-z0-9_:-]*))?\s*/" % type )

    rg.each do |x|
      if re.match( buf[x] )
        next if type == "def" && eval( VIM::evaluate("s:IsPosInClassDef(%s)" % x) ) != nil
        ret.push $1
      end
    end

    return ret
  end

  def get_buffer_modules
    return get_buffer_entity_list( "modules" )
  end

  def get_buffer_methods
    return get_buffer_entity_list( "def" )
  end

  def get_buffer_classes
    return get_buffer_entity_list( "class" )
  end


  def load_rails
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    return if allow_rails != '1'

    buf_path = VIM::evaluate('expand("%:p")')
    file_name = VIM::evaluate('expand("%:t")')
    vim_dir = VIM::evaluate('getcwd()')
    file_dir = buf_path.gsub( file_name, '' )
    file_dir.gsub!( /\\/, "/" )
    vim_dir.gsub!( /\\/, "/" )
    vim_dir << "/"
    dirs = [ vim_dir, file_dir ]
    sdirs = [ "", "./", "../", "../../", "../../../", "../../../../" ]
    rails_base = nil

    dirs.each do |dir|
      sdirs.each do |sub|
        trail = "%s%s" % [ dir, sub ]
        tcfg = "%sconfig" % trail

        if File.exists?( tcfg )
          rails_base = trail
          break
        end
      end
      break if rails_base
    end

    return if rails_base == nil
    $:.push rails_base unless $:.index( rails_base )

    rails_config = rails_base + "config/"
    rails_lib = rails_base + "lib/"
    $:.push rails_config unless $:.index( rails_config )
    $:.push rails_lib unless $:.index( rails_lib )

    bootfile = rails_config + "boot.rb"
    envfile = rails_config + "environment.rb"
    if File.exists?( bootfile ) && File.exists?( envfile )
      begin
        require bootfile
        require envfile
        begin
          require 'console_app'
          require 'console_with_helpers'
        rescue Exception
          dprint "Rails 1.1+ Error %s" % $!
          # assume 1.0
        end
        #eval( "Rails::Initializer.run" ) #not necessary?
        VIM::command('let s:rubycomplete_rails_loaded = 1')
        dprint "rails loaded"
      rescue Exception
        dprint "Rails Error %s" % $!
        VIM::evaluate( "s:ErrMsg('Error loading rails environment')" )
      end
    end
  end

  def get_rails_helpers
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    rails_loaded = VIM::evaluate('s:rubycomplete_rails_loaded')
    return [] if allow_rails != '1' || rails_loaded != '1'

    buf_path = VIM::evaluate('expand("%:p")')
    buf_path.gsub!( /\\/, "/" )
    path_elm = buf_path.split( "/" )
    dprint "buf_path: %s" % buf_path
    types = [ "app", "db", "lib", "test", "components", "script" ]

    i = nil
    ret = []
    type = nil
    types.each do |t|
      i = path_elm.index( t )
      break if i
    end
    type = path_elm[i]
    type.downcase!

    dprint "type: %s" % type
    case type
      when "app"
        i += 1
        subtype = path_elm[i]
        subtype.downcase!

        dprint "subtype: %s" % subtype
        case subtype
          when "views"
            ret += ActionView::Base.instance_methods
            ret += ActionView::Base.methods
          when "controllers"
            ret += ActionController::Base.instance_methods
            ret += ActionController::Base.methods
          when "models"
            ret += ActiveRecord::Base.instance_methods
            ret += ActiveRecord::Base.methods
        end

      when "db"
        ret += ActiveRecord::ConnectionAdapters::SchemaStatements.instance_methods
        ret += ActiveRecord::ConnectionAdapters::SchemaStatements.methods
    end


    return ret
  end

  def add_rails_columns( cls )
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    rails_loaded = VIM::evaluate('s:rubycomplete_rails_loaded')
    return [] if allow_rails != '1' || rails_loaded != '1'

    begin
        eval( "#{cls}.establish_connection" )
        return [] unless eval( "#{cls}.ancestors.include?(ActiveRecord::Base).to_s" )
        col = eval( "#{cls}.column_names" )
        return col if col
    rescue
        dprint "add_rails_columns err: (cls: %s) %s" % [ cls, $! ]
        return []
    end
    return []
  end

  def clean_sel(sel, msg)
    sel.delete_if { |x| x == nil }
    sel.uniq!
    sel.grep(/^#{Regexp.quote(msg)}/) if msg != nil
  end

  def get_rails_view_methods
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    rails_loaded = VIM::evaluate('s:rubycomplete_rails_loaded')
    return [] if allow_rails != '1' || rails_loaded != '1'

    buf_path = VIM::evaluate('expand("%:p")')
    buf_path.gsub!( /\\/, "/" )
    pelm = buf_path.split( "/" )
    idx = pelm.index( "views" )

    return [] unless idx
    idx += 1

    clspl = pelm[idx].camelize.pluralize
    cls = clspl.singularize

    ret = []
    begin
      ret += eval( "#{cls}.instance_methods" )
      ret += eval( "#{clspl}Helper.instance_methods" )
    rescue Exception
      dprint "Error: Unable to load rails view helpers for %s: %s" % [ cls, $! ]
    end

    return ret
  end
# }}} buffer analysis magic

# {{{ main completion code
  def self.preload_rails
    a = VimRubyCompletion.new
    require 'Thread'
    Thread.new(a) do |b|
      begin
      b.load_rails
      rescue
      end
    end
    a.load_rails
  rescue
  end

  def self.get_completions(base)
    b = VimRubyCompletion.new
    b.get_completions base
  end

  def get_completions(base)
    loading_allowed = VIM::evaluate("exists('g:rubycomplete_buffer_loading') && g:rubycomplete_buffer_loading")
    if loading_allowed == '1'
      load_requires
      load_rails
    end

    input = VIM::Buffer.current.line
    cpos = VIM::Window.current.cursor[1] - 1
    input = input[0..cpos]
    input += base
    input.sub!(/.*[ \t\n\"\\'`><=;|&{(]/, '') # Readline.basic_word_break_characters
    input.sub!(/self\./, '')
    input.sub!(/.*((\.\.[\[(]?)|([\[(]))/, '')

    dprint 'input %s' % input
    message = nil
    receiver = nil
    methods = []
    variables = []
    classes = []
    constants = []

    case input
      when /^(\/[^\/]*\/)\.([^.]*)$/ # Regexp
        receiver = $1
        message = Regexp.quote($2)
        methods = Regexp.instance_methods(true)

      when /^([^\]]*\])\.([^.]*)$/ # Array
        receiver = $1
        message = Regexp.quote($2)
        methods = Array.instance_methods(true)

      when /^([^\}]*\})\.([^.]*)$/ # Proc or Hash
        receiver = $1
        message = Regexp.quote($2)
        methods = Proc.instance_methods(true) | Hash.instance_methods(true)

      when /^(:[^:.]*)$/ # Symbol
        dprint "symbol"
        if Symbol.respond_to?(:all_symbols)
          receiver = $1
          message = $1.sub( /:/, '' )
          methods = Symbol.all_symbols.collect{|s| s.id2name}
          methods.delete_if { |c| c.match( /'/ ) }
        end

      when /^::([A-Z][^:\.\(]*)$/ # Absolute Constant or class methods
        dprint "const or cls"
        receiver = $1
        methods = Object.constants
        methods.grep(/^#{receiver}/).collect{|e| "::" + e}

      when /^(((::)?[A-Z][^:.\(]*)+)::?([^:.]*)$/ # Constant or class methods
        receiver = $1
        message = Regexp.quote($4)
        dprint "const or cls 2 [recv: \'%s\', msg: \'%s\']" % [ receiver, message ]
        load_buffer_class( receiver )
        begin
          classes = eval("#{receiver}.constants")
          #methods = eval("#{receiver}.methods")
        rescue Exception
          dprint "exception: %s" % $!
          methods = []
        end
        methods.grep(/^#{message}/).collect{|e| receiver + "::" + e}

      when /^(:[^:.]+)\.([^.]*)$/ # Symbol
        dprint "symbol"
        receiver = $1
        message = Regexp.quote($2)
        methods = Symbol.instance_methods(true)

      when /^([0-9_]+(\.[0-9_]+)?(e[0-9]+)?)\.([^.]*)$/ # Numeric
        dprint "numeric"
        receiver = $1
        message = Regexp.quote($4)
        begin
          methods = eval(receiver).methods
        rescue Exception
          methods = []
        end

      when /^(\$[^.]*)$/ #global
        dprint "global"
        methods = global_variables.grep(Regexp.new(Regexp.quote($1)))

      when /^((\.?[^.]+)+)\.([^.]*)$/ # variable
        dprint "variable"
        receiver = $1
        message = Regexp.quote($3)
        load_buffer_class( receiver )

        cv = eval("self.class.constants")
        vartype = get_var_type( receiver )
        dprint "vartype: %s" % vartype
        if vartype != ''
          load_buffer_class( vartype )

          begin
            methods = eval("#{vartype}.instance_methods")
            variables = eval("#{vartype}.instance_variables")
          rescue Exception
            dprint "load_buffer_class err: %s" % $!
          end
        elsif (cv).include?(receiver)
          # foo.func and foo is local var.
          methods = eval("#{receiver}.methods")
          vartype = receiver
        elsif /^[A-Z]/ =~ receiver and /\./ !~ receiver
          vartype = receiver
          # Foo::Bar.func
          begin
            methods = eval("#{receiver}.methods")
          rescue Exception
          end
        else
          # func1.func2
          ObjectSpace.each_object(Module){|m|
            next if m.name != "IRB::Context" and
              /^(IRB|SLex|RubyLex|RubyToken)/ =~ m.name
            methods.concat m.instance_methods(false)
          }
        end
        variables += add_rails_columns( "#{vartype}" ) if vartype && vartype.length > 0

      when /^\(?\s*[A-Za-z0-9:^@.%\/+*\(\)]+\.\.\.?[A-Za-z0-9:^@.%\/+*\(\)]+\s*\)?\.([^.]*)/
        message = $1
        methods = Range.instance_methods(true)

      when /^\.([^.]*)$/ # unknown(maybe String)
        message = Regexp.quote($1)
        methods = String.instance_methods(true)

    else
      dprint "default/other"
      inclass = eval( VIM::evaluate("s:IsInClassDef()") )

      if inclass != nil
        dprint "inclass"
        classdef = "%s\n" % VIM::Buffer.current[ inclass.min ]
        found = /^\s*class\s*([A-Za-z0-9_-]*)(\s*<\s*([A-Za-z0-9_:-]*))?\s*\n$/.match( classdef )

        if found != nil
          receiver = $1
          message = input
          load_buffer_class( receiver )
          begin
            methods = eval( "#{receiver}.instance_methods" )
            variables += add_rails_columns( "#{receiver}" )
          rescue Exception
            found = nil
          end
        end
      end

      if inclass == nil || found == nil
        dprint "inclass == nil"
        methods = get_buffer_methods
        methods += get_rails_view_methods

        cls_const = Class.constants
        constants = cls_const.select { |c| /^[A-Z_-]+$/.match( c ) }
        classes = eval("self.class.constants") - constants
        classes += get_buffer_classes
        classes += get_buffer_modules

        include_objectspace = VIM::evaluate("exists('g:rubycomplete_include_objectspace') && g:rubycomplete_include_objectspace")
        ObjectSpace.each_object(Class) { |cls| classes << cls.to_s } if include_objectspace == "1"
        message = receiver = input
      end

      methods += get_rails_helpers
      methods += Kernel.public_methods
    end


    include_object = VIM::evaluate("exists('g:rubycomplete_include_object') && g:rubycomplete_include_object")
    methods = clean_sel( methods, message )
    methods = (methods-Object.instance_methods) if include_object == "0"
    rbcmeth = (VimRubyCompletion.instance_methods-Object.instance_methods) # lets remove those rubycomplete methods
    methods = (methods-rbcmeth)

    variables = clean_sel( variables, message )
    classes = clean_sel( classes, message ) - ["VimRubyCompletion"]
    constants = clean_sel( constants, message )

    valid = []
    valid += methods.collect { |m| { :name => m, :type => 'm' } }
    valid += variables.collect { |v| { :name => v, :type => 'v' } }
    valid += classes.collect { |c| { :name => c, :type => 't' } }
    valid += constants.collect { |d| { :name => d, :type => 'd' } }
    valid.sort! { |x,y| x[:name] <=> y[:name] }

    outp = ""

    rg = 0..valid.length
    rg.step(150) do |x|
      stpos = 0+x
      enpos = 150+x
      valid[stpos..enpos].each { |c| outp += "{'word':'%s','item':'%s','kind':'%s'}," % [ c[:name], c[:name], c[:type] ] }
      outp.sub!(/,$/, '')

      VIM::command("call extend(g:rubycomplete_completions, [%s])" % outp)
      outp = ""
    end
  end
# }}} main completion code

end # VimRubyCompletion
# }}} ruby completion
RUBYEOF
endfunction

let s:rubycomplete_rails_loaded = 0

call s:DefRuby()
"}}} ruby-side code


" vim:tw=78:sw=4:ts=8:et:fdm=marker:ft=vim:norl:
compiler/eruby.vim
41
" Vim compiler file
" Language:		eRuby
" Maintainer:		Doug Kearns <dougkearns@gmail.com>
" Info:			$Id: eruby.vim,v 1.6 2006/04/15 12:01:18 dkearns Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "eruby"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

if exists("eruby_compiler") && eruby_compiler == "eruby"
  CompilerSet makeprg=eruby
else
  CompilerSet makeprg=erb
endif

CompilerSet errorformat=
    \eruby:\ %f:%l:%m,
    \%+E%f:%l:\ parse\ error,
    \%W%f:%l:\ warning:\ %m,
    \%E%f:%l:in\ %*[^:]:\ %m,
    \%E%f:%l:\ %m,
    \%-C%\tfrom\ %f:%l:in\ %.%#,
    \%-Z%\tfrom\ %f:%l,
    \%-Z%p^,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 ff=unix:
compiler/ruby.vim
68
" Vim compiler file
" Language:		Ruby
" Function:		Syntax check and/or error reporting
" Maintainer:		Tim Hammerquist <timh at rubyforge.org>
" Info:			$Id: ruby.vim,v 1.12 2006/04/15 12:01:18 dkearns Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>
" ----------------------------------------------------------------------------
"
" Changelog:
" 0.2:	script saves and restores 'cpoptions' value to prevent problems with
"	line continuations
" 0.1:	initial release
"
" Contributors:
"   Hugh Sasse <hgs@dmu.ac.uk>
"   Doug Kearns <djkea2@gus.gscit.monash.edu.au>
"
" Todo:
"   match error type %m
"
" Comments:
"   I know this file isn't perfect.  If you have any questions, suggestions,
"   patches, etc., please don't hesitate to let me know.
"
"   This is my first experience with 'errorformat' and compiler plugins and
"   I welcome any input from more experienced (or clearer-thinking)
"   individuals.
" ----------------------------------------------------------------------------

if exists("current_compiler")
  finish
endif
let current_compiler = "ruby"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

" default settings runs script normally
" add '-c' switch to run syntax check only:
"
"   CompilerSet makeprg=ruby\ -wc\ $*
"
" or add '-c' at :make command line:
"
"   :make -c %<CR>
"
CompilerSet makeprg=ruby\ -w\ $*

CompilerSet errorformat=
    \%+E%f:%l:\ parse\ error,
    \%W%f:%l:\ warning:\ %m,
    \%E%f:%l:in\ %*[^:]:\ %m,
    \%E%f:%l:\ %m,
    \%-C%\tfrom\ %f:%l:in\ %.%#,
    \%-Z%\tfrom\ %f:%l,
    \%-Z%p^,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 ff=unix:
compiler/rubyunit.vim
35
" Vim compiler file
" Language:		Test::Unit - Ruby Unit Testing Framework
" Maintainer:		Doug Kearns <dougkearns@gmail.com>
" Info:			$Id: rubyunit.vim,v 1.11 2006/04/15 12:01:18 dkearns Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "rubyunit"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=testrb

CompilerSet errorformat=\%W\ %\\+%\\d%\\+)\ Failure:,
			\%C%m\ [%f:%l]:,
			\%E\ %\\+%\\d%\\+)\ Error:,
			\%C%m:,
			\%C\ \ \ \ %f:%l:%.%#,
			\%C%m,
			\%Z\ %#,
			\%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 ff=unix:
ftdetect/ruby.vim
14
" Ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gem,*.gemspec	set filetype=ruby

" Ruby on Rails
au BufNewFile,BufRead *.builder,*.rxml,*.rjs		set filetype=ruby

" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake		set filetype=ruby

" Rantfile
au BufNewFile,BufRead [rR]antfile,*.rant		set filetype=ruby

" eRuby
au BufNewFile,BufRead *.erb,*.rhtml			set filetype=eruby
ftplugin/eruby.vim
101
" Vim filetype plugin
" Language:		eRuby
" Maintainer:		Tim Pope <vimNOSPAM@tpope.info>
" Info:			$Id: eruby.vim,v 1.10 2007/05/06 16:05:40 tpope Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let s:save_cpo = &cpo
set cpo-=C

" Define some defaults in case the included ftplugins don't set them.
let s:undo_ftplugin = ""
let s:browsefilter = "All Files (*.*)\t*.*\n"
let s:match_words = ""

if !exists("g:eruby_default_subtype")
  let g:eruby_default_subtype = "html"
endif

if !exists("b:eruby_subtype")
  let s:lines = getline(1)."\n".getline(2)."\n".getline(3)."\n".getline(4)."\n".getline(5)."\n".getline("$")
  let b:eruby_subtype = matchstr(s:lines,'eruby_subtype=\zs\w\+')
  if b:eruby_subtype == ''
    let b:eruby_subtype = matchstr(substitute(expand("%:t"),'\c\%(\.erb\)\+$','',''),'\.\zs\w\+$')
  endif
  if b:eruby_subtype == 'rhtml'
    let b:eruby_subtype = 'html'
  elseif b:eruby_subtype == 'rb'
    let b:eruby_subtype = 'ruby'
  elseif b:eruby_subtype == 'yml'
    let b:eruby_subtype = 'yaml'
  elseif b:eruby_subtype == 'js'
    let b:eruby_subtype = 'javascript'
  elseif b:eruby_subtype == 'txt'
    " Conventional; not a real file type
    let b:eruby_subtype = 'text'
  elseif b:eruby_subtype == ''
    let b:eruby_subtype = g:eruby_default_subtype
  endif
endif

if exists("b:eruby_subtype") && b:eruby_subtype != ''
  exe "runtime! ftplugin/".b:eruby_subtype.".vim ftplugin/".b:eruby_subtype."_*.vim ftplugin/".b:eruby_subtype."/*.vim"
else
  runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim
endif
unlet! b:did_ftplugin

" Override our defaults if these were set by an included ftplugin.
if exists("b:undo_ftplugin")
  let s:undo_ftplugin = b:undo_ftplugin
  unlet b:undo_ftplugin
endif
if exists("b:browsefilter")
  let s:browsefilter = b:browsefilter
  unlet b:browsefilter
endif
if exists("b:match_words")
  let s:match_words = b:match_words
  unlet b:match_words
endif

runtime! ftplugin/ruby.vim ftplugin/ruby_*.vim ftplugin/ruby/*.vim
let b:did_ftplugin = 1

" Combine the new set of values with those previously included.
if exists("b:undo_ftplugin")
  let s:undo_ftplugin = b:undo_ftplugin . " | " . s:undo_ftplugin
endif
if exists ("b:browsefilter")
  let s:browsefilter = substitute(b:browsefilter,'\cAll Files (\*\.\*)\t\*\.\*\n','','') . s:browsefilter
endif
if exists("b:match_words")
  let s:match_words = b:match_words . ',' . s:match_words
endif

" Change the browse dialog on Win32 to show mainly eRuby-related files
if has("gui_win32")
  let b:browsefilter="eRuby Files (*.erb, *.rhtml)\t*.erb;*.rhtml\n" . s:browsefilter
endif

" Load the combined list of match_words for matchit.vim
if exists("loaded_matchit")
  let b:match_words = s:match_words
endif

" TODO: comments=
setlocal commentstring=<%#%s%>

let b:undo_ftplugin = "setl cms< "
      \ " | unlet! b:browsefilter b:match_words | " . s:undo_ftplugin

let &cpo = s:save_cpo

" vim: nowrap sw=2 sts=2 ts=8 ff=unix:
ftplugin/ruby.vim
230
" Vim filetype plugin
" Language:		Ruby
" Maintainer:		Gavin Sinclair <gsinclair at gmail.com>
" Info:			$Id: ruby.vim,v 1.39 2007/05/06 16:38:40 tpope Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:  Doug Kearns <dougkearns@gmail.com>
" ----------------------------------------------------------------------------
"
" Original matchit support thanks to Ned Konz.  See his ftplugin/ruby.vim at
"   http://bike-nomad.com/vim/ruby.vim.
" ----------------------------------------------------------------------------

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

if has("gui_running") && !has("gui_win32")
  setlocal keywordprg=ri\ -T
else
  setlocal keywordprg=ri
endif

" Matchit support
if exists("loaded_matchit") && !exists("b:match_words")
  let b:match_ignorecase = 0

  let b:match_words =
	\ '\<\%(if\|unless\|case\|while\|until\|for\|do\|class\|module\|def\|begin\)\>=\@!' .
	\ ':' .
	\ '\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>' .
	\ ':' .
	\ '\<end\>' .
	\ ',{:},\[:\],(:)'

  let b:match_skip =
	\ "synIDattr(synID(line('.'),col('.'),0),'name') =~ '" .
	\ "\\<ruby\\%(String\\|StringDelimiter\\|ASCIICode\\|Escape\\|" .
	\ "Interpolation\\|NoInterpolation\\|Comment\\|Documentation\\|" .
	\ "ConditionalModifier\\|RepeatModifier\\|OptionalDo\\|" .
	\ "Function\\|BlockArgument\\|KeywordAsMethod\\|ClassVariable\\|" .
	\ "InstanceVariable\\|GlobalVariable\\|Symbol\\)\\>'"
endif

setlocal formatoptions-=t formatoptions+=croql

setlocal include=^\\s*\\<\\(load\\\|\w*require\\)\\>
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.rb','')
setlocal suffixesadd=.rb

if exists("&ofu") && has("ruby")
  setlocal omnifunc=rubycomplete#Complete
endif

" To activate, :set ballooneval
if has('balloon_eval') && exists('+balloonexpr')
  setlocal balloonexpr=RubyBalloonexpr()
endif


" TODO:
"setlocal define=^\\s*def

setlocal comments=:#
setlocal commentstring=#\ %s

if !exists("s:rubypath")
  if has("ruby") && has("win32")
    ruby VIM::command( 'let s:rubypath = "%s"' % ($: + begin; require %q{rubygems}; Gem.all_load_paths.sort.uniq; rescue LoadError; []; end).join(%q{,}) )
    let s:rubypath = '.,' . substitute(s:rubypath, '\%(^\|,\)\.\%(,\|$\)', ',,', '')
  elseif executable("ruby")
    let s:code = "print ($: + begin; require %q{rubygems}; Gem.all_load_paths.sort.uniq; rescue LoadError; []; end).join(%q{,})"
    if &shellxquote == "'"
      let s:rubypath = system('ruby -e "' . s:code . '"')
    else
      let s:rubypath = system("ruby -e '" . s:code . "'")
    endif
    let s:rubypath = '.,' . substitute(s:rubypath, '\%(^\|,\)\.\%(,\|$\)', ',,', '')
  else
    " If we can't call ruby to get its path, just default to using the
    " current directory and the directory of the current file.
    let s:rubypath = ".,,"
  endif
endif

let &l:path = s:rubypath

if has("gui_win32") && !exists("b:browsefilter")
  let b:browsefilter = "Ruby Source Files (*.rb)\t*.rb\n" .
                     \ "All Files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setl fo< inc< inex< sua< def< com< cms< path< kp<"
      \."| unlet! b:browsefilter b:match_ignorecase b:match_words b:match_skip"
      \."| if exists('&ofu') && has('ruby') | setl ofu< | endif"
      \."| if has('balloon_eval') && exists('+bexpr') | setl bexpr< | endif"

if !exists("g:no_plugin_maps") && !exists("g:no_ruby_maps")

  noremap <silent> <buffer> [m :<C-U>call <SID>searchsyn('\<def\>','rubyDefine','b')<CR>
  noremap <silent> <buffer> ]m :<C-U>call <SID>searchsyn('\<def\>','rubyDefine','')<CR>
  noremap <silent> <buffer> [M :<C-U>call <SID>searchsyn('\<end\>','rubyDefine','b')<CR>
  noremap <silent> <buffer> ]M :<C-U>call <SID>searchsyn('\<end\>','rubyDefine','')<CR>

  noremap <silent> <buffer> [[ :<C-U>call <SID>searchsyn('\<\%(class\<Bar>module\)\>','rubyModule\<Bar>rubyClass','b')<CR>
  noremap <silent> <buffer> ]] :<C-U>call <SID>searchsyn('\<\%(class\<Bar>module\)\>','rubyModule\<Bar>rubyClass','')<CR>
  noremap <silent> <buffer> [] :<C-U>call <SID>searchsyn('\<end\>','rubyModule\<Bar>rubyClass','b')<CR>
  noremap <silent> <buffer> ][ :<C-U>call <SID>searchsyn('\<end\>','rubyModule\<Bar>rubyClass','')<CR>

  let b:undo_ftplugin = b:undo_ftplugin
        \."| sil! exe 'unmap <buffer> [[' | sil! exe 'unmap <buffer> ]]' | sil! exe 'unmap <buffer> []' | sil! exe 'unmap <buffer> ]['"
        \."| sil! exe 'unmap <buffer> [m' | sil! exe 'unmap <buffer> ]m' | sil! exe 'unmap <buffer> [M' | sil! exe 'unmap <buffer> ]M'"
endif

let &cpo = s:cpo_save
unlet s:cpo_save

if exists("g:did_ruby_ftplugin_functions")
  finish
endif
let g:did_ruby_ftplugin_functions = 1

function! RubyBalloonexpr()
  if !exists('s:ri_found')
    let s:ri_found = executable('ri')
  endif
  if s:ri_found
    let line = getline(v:beval_lnum)
    let b = matchstr(strpart(line,0,v:beval_col),'\%(\w\|[:.]\)*$')
    let a = substitute(matchstr(strpart(line,v:beval_col),'^\w*\%([?!]\|\s*=\)\?'),'\s\+','','g')
    let str = b.a
    let before = strpart(line,0,v:beval_col-strlen(b))
    let after  = strpart(line,v:beval_col+strlen(a))
    if str =~ '^\.'
      let str = substitute(str,'^\.','#','g')
      if before =~ '\]\s*$'
        let str = 'Array'.str
      elseif before =~ '}\s*$'
        " False positives from blocks here
        let str = 'Hash'.str
      elseif before =~ "[\"'`]\\s*$" || before =~ '\$\d\+\s*$'
        let str = 'String'.str
      elseif before =~ '\$\d\+\.\d\+\s*$'
        let str = 'Float'.str
      elseif before =~ '\$\d\+\s*$'
        let str = 'Integer'.str
      elseif before =~ '/\s*$'
        let str = 'Regexp'.str
      else
        let str = substitute(str,'^#','.','')
      endif
    endif
    let str = substitute(str,'.*\.\s*to_f\s*\.\s*','Float#','')
    let str = substitute(str,'.*\.\s*to_i\%(nt\)\=\s*\.\s*','Integer#','')
    let str = substitute(str,'.*\.\s*to_s\%(tr\)\=\s*\.\s*','String#','')
    let str = substitute(str,'.*\.\s*to_sym\s*\.\s*','Symbol#','')
    let str = substitute(str,'.*\.\s*to_a\%(ry\)\=\s*\.\s*','Array#','')
    let str = substitute(str,'.*\.\s*to_proc\s*\.\s*','Proc#','')
    if str !~ '^\w'
      return ''
    endif
    silent! let res = substitute(system("ri -f simple -T \"".str.'"'),'\n$','','')
    if res =~ '^Nothing known about' || res =~ '^Bad argument:' || res =~ '^More than one method'
      return ''
    endif
    return res
  else
    return ""
  endif
endfunction

function! s:searchsyn(pattern,syn,flags)
    norm! m'
    let i = 0
    let cnt = v:count ? v:count : 1
    while i < cnt
        let i = i + 1
        let line = line('.')
        let col  = col('.')
        let pos = search(a:pattern,'W'.a:flags)
        while pos != 0 && s:synname() !~# a:syn
            let pos = search(a:pattern,'W'.a:flags)
        endwhile
        if pos == 0
            call cursor(line,col)
            return
        endif
    endwhile
endfunction

function! s:synname()
    return synIDattr(synID(line('.'),col('.'),0),'name')
endfunction

"
" Instructions for enabling "matchit" support:
"
" 1. Look for the latest "matchit" plugin at
"
"         http://www.vim.org/scripts/script.php?script_id=39
"
"    It is also packaged with Vim, in the $VIMRUNTIME/macros directory.
"
" 2. Copy "matchit.txt" into a "doc" directory (e.g. $HOME/.vim/doc).
"
" 3. Copy "matchit.vim" into a "plugin" directory (e.g. $HOME/.vim/plugin).
"
" 4. Ensure this file (ftplugin/ruby.vim) is installed.
"
" 5. Ensure you have this line in your $HOME/.vimrc:
"         filetype plugin on
"
" 6. Restart Vim and create the matchit documentation:
"
"         :helptags ~/.vim/doc
"
"    Now you can do ":help matchit", and you should be able to use "%" on Ruby
"    keywords.  Try ":echo b:match_words" to be sure.
"
" Thanks to Mark J. Reed for the instructions.  See ":help vimrc" for the
" locations of plugin directories, etc., as there are several options, and it
" differs on Windows.  Email gsinclair@soyabean.com.au if you need help.
"

" vim: nowrap sw=2 sts=2 ts=8 ff=unix:
indent/eruby.vim
73
" Vim indent file
" Language:		eRuby
" Maintainer:		Tim Pope <vimNOSPAM@tpope.info>
" Info:			$Id: eruby.vim,v 1.9 2007/04/16 17:03:36 tpope Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

if exists("b:did_indent")
  finish
endif

runtime! indent/ruby.vim
unlet! b:did_indent
set indentexpr=

if exists("b:eruby_subtype")
  exe "runtime! indent/".b:eruby_subtype.".vim"
else
  runtime! indent/html.vim
endif
unlet! b:did_indent

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:eruby_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1

setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when

" Only define the function once.
if exists("*GetErubyIndent")
  finish
endif

function! GetErubyIndent()
  let vcol = col('.')
  call cursor(v:lnum,1)
  let inruby = searchpair('<%','','%>')
  call cursor(v:lnum,vcol)
  if inruby && getline(v:lnum) !~ '^<%'
    let ind = GetRubyIndent()
  else
    exe "let ind = ".b:eruby_subtype_indentexpr
  endif
  let lnum = prevnonblank(v:lnum-1)
  let line = getline(lnum)
  let cline = getline(v:lnum)
  if cline =~# '<%\s*\%(end\|else\|\%(ensure\|rescue\|elsif\|when\).\{-\}\)\s*\%(-\=%>\|$\)'
    let ind = ind - &sw
  endif
  if line =~# '\<do\%(\s*|[^|]*|\)\=\s*-\=%>'
    let ind = ind + &sw
  elseif line =~# '<%\s*\%(module\|class\|def\|if\|for\|while\|until\|else\|elsif\|case\|when\|unless\|begin\|ensure\|rescue\)\>.*%>'
    let ind = ind + &sw
  endif
  if line =~# '^\s*<%[=#]\=\s*$' && cline !~# '^\s*end\>'
    let ind = ind + &sw
  endif
  if cline =~# '^\s*-\=%>\s*$'
    let ind = ind - &sw
  endif
  return ind
endfunction

" vim:set sw=2 sts=2 ts=8 noet ff=unix:
indent/ruby.vim
373
" Vim indent file
" Language:		Ruby
" Maintainer:		Nikolai Weibull <now at bitwi.se>
" Info:			$Id: ruby.vim,v 1.40 2007/03/20 13:54:25 dkearns Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

" 0. Initialization {{{1
" =================

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

" Now, set up our indentation expression and keys that trigger it.
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e
setlocal indentkeys+==end,=elsif,=when,=ensure,=rescue,==begin,==end

" Only define the function once.
if exists("*GetRubyIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" 1. Variables {{{1
" ============

" Regex of syntax group names that are or delimit string or are comments.
let s:syng_strcom = '\<ruby\%(String\|StringDelimiter\|ASCIICode' .
      \ '\|Interpolation\|NoInterpolation\|Escape\|Comment\|Documentation\)\>'

" Regex of syntax group names that are strings.
let s:syng_string =
      \ '\<ruby\%(String\|StringDelimiter\|Interpolation\|NoInterpolation\|Escape\)\>'

" Regex of syntax group names that are strings or documentation.
let s:syng_stringdoc =
  \'\<ruby\%(String\|StringDelimiter\|Interpolation\|NoInterpolation\|Escape\|Documentation\)\>'

" Expression used to check whether we should skip a match with searchpair().
let s:skip_expr =
      \ "synIDattr(synID(line('.'),col('.'),0),'name') =~ '".s:syng_strcom."'"

" Regex used for words that, at the start of a line, add a level of indent.
let s:ruby_indent_keywords = '^\s*\zs\<\%(module\|class\|def\|if\|for' .
      \ '\|while\|until\|else\|elsif\|case\|when\|unless\|begin\|ensure' .
      \ '\|rescue\)\>' .
      \ '\|\%([*+/,=:-]\|<<\|>>\)\s*\zs' .
      \    '\<\%(if\|for\|while\|until\|case\|unless\|begin\)\>'

" Regex used for words that, at the start of a line, remove a level of indent.
let s:ruby_deindent_keywords =
      \ '^\s*\zs\<\%(ensure\|else\|rescue\|elsif\|when\|end\)\>'

" Regex that defines the start-match for the 'end' keyword.
"let s:end_start_regex = '\%(^\|[^.]\)\<\%(module\|class\|def\|if\|for\|while\|until\|case\|unless\|begin\|do\)\>'
" TODO: the do here should be restricted somewhat (only at end of line)?
let s:end_start_regex = '^\s*\zs\<\%(module\|class\|def\|if\|for' .
      \ '\|while\|until\|case\|unless\|begin\)\>' .
      \ '\|\%([*+/,=:-]\|<<\|>>\)\s*\zs' .
      \    '\<\%(if\|for\|while\|until\|case\|unless\|begin\)\>' .
      \ '\|\<do\>'

" Regex that defines the middle-match for the 'end' keyword.
let s:end_middle_regex = '\<\%(ensure\|else\|\%(\%(^\|;\)\s*\)\@<=\<rescue\>\|when\|elsif\)\>'

" Regex that defines the end-match for the 'end' keyword.
let s:end_end_regex = '\%(^\|[^.:@$]\)\@<=\<end\>'

" Expression used for searchpair() call for finding match for 'end' keyword.
let s:end_skip_expr = s:skip_expr .
      \ ' || (expand("<cword>") == "do"' .
      \ ' && getline(".") =~ "^\\s*\\<while\\|until\\|for\\>")'

" Regex that defines continuation lines, not including (, {, or [.
let s:continuation_regex = '\%([\\*+/.,=:-]\|\W[|&?]\|||\|&&\)\s*\%(#.*\)\=$'

" Regex that defines continuation lines.
" TODO: this needs to deal with if ...: and so on
let s:continuation_regex2 =
      \ '\%([\\*+/.,=:({[-]\|\W[|&?]\|||\|&&\)\s*\%(#.*\)\=$'

" Regex that defines blocks.
let s:block_regex =
      \ '\%(\<do\>\|{\)\s*\%(|\%([*@]\=\h\w*,\=\s*\)\%(,\s*[*@]\=\h\w*\)*|\)\=\s*\%(#.*\)\=$'

" 2. Auxiliary Functions {{{1
" ======================

" Check if the character at lnum:col is inside a string, comment, or is ascii.
function s:IsInStringOrComment(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 0), 'name') =~ s:syng_strcom
endfunction

" Check if the character at lnum:col is inside a string.
function s:IsInString(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 0), 'name') =~ s:syng_string
endfunction

" Check if the character at lnum:col is inside a string or documentation.
function s:IsInStringOrDocumentation(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 0), 'name') =~ s:syng_stringdoc
endfunction

" Find line above 'lnum' that isn't empty, in a comment, or in a string.
function s:PrevNonBlankNonString(lnum)
  let in_block = 0
  let lnum = prevnonblank(a:lnum)
  while lnum > 0
    " Go in and out of blocks comments as necessary.
    " If the line isn't empty (with opt. comment) or in a string, end search.
    let line = getline(lnum)
    if line =~ '^=begin$'
      if in_block
	let in_block = 0
      else
	break
      endif
    elseif !in_block && line =~ '^=end$'
      let in_block = 1
    elseif !in_block && line !~ '^\s*#.*$' && !(s:IsInStringOrComment(lnum, 1)
	  \ && s:IsInStringOrComment(lnum, strlen(line)))
      break
    endif
    let lnum = prevnonblank(lnum - 1)
  endwhile
  return lnum
endfunction

" Find line above 'lnum' that started the continuation 'lnum' may be part of.
function s:GetMSL(lnum)
  " Start on the line we're at and use its indent.
  let msl = a:lnum
  let lnum = s:PrevNonBlankNonString(a:lnum - 1)
  while lnum > 0
    " If we have a continuation line, or we're in a string, use line as MSL.
    " Otherwise, terminate search as we have found our MSL already.
    let line = getline(lnum)
    let col = match(line, s:continuation_regex2) + 1
    if (col > 0 && !s:IsInStringOrComment(lnum, col))
	  \ || s:IsInString(lnum, strlen(line))
      let msl = lnum
    else
      break
    endif
    let lnum = s:PrevNonBlankNonString(lnum - 1)
  endwhile
  return msl
endfunction

" Check if line 'lnum' has more opening brackets than closing ones.
function s:LineHasOpeningBrackets(lnum)
  let open_0 = 0
  let open_2 = 0
  let open_4 = 0
  let line = getline(a:lnum)
  let pos = match(line, '[][(){}]', 0)
  while pos != -1
    if !s:IsInStringOrComment(a:lnum, pos + 1)
      let idx = stridx('(){}[]', line[pos])
      if idx % 2 == 0
	let open_{idx} = open_{idx} + 1
      else
	let open_{idx - 1} = open_{idx - 1} - 1
      endif
    endif
    let pos = match(line, '[][(){}]', pos + 1)
  endwhile
  return (open_0 > 0) . (open_2 > 0) . (open_4 > 0)
endfunction

function s:Match(lnum, regex)
  let col = match(getline(a:lnum), a:regex) + 1
  return col > 0 && !s:IsInStringOrComment(a:lnum, col) ? col : 0
endfunction

function s:MatchLast(lnum, regex)
  let line = getline(a:lnum)
  let col = match(line, '.*\zs' . a:regex)
  while col != -1 && s:IsInStringOrComment(a:lnum, col)
    let line = strpart(line, 0, col)
    let col = match(line, '.*' . a:regex)
  endwhile
  return col + 1
endfunction

" 3. GetRubyIndent Function {{{1
" =========================

function GetRubyIndent()
  " 3.1. Setup {{{2
  " ----------

  " Set up variables for restoring position in file.  Could use v:lnum here.
  let vcol = col('.')

  " 3.2. Work on the current line {{{2
  " -----------------------------

  " Get the current line.
  let line = getline(v:lnum)
  let ind = -1

  " If we got a closing bracket on an empty line, find its match and indent
  " according to it.  For parentheses we indent to its column - 1, for the
  " others we indent to the containing line's MSL's level.  Return -1 if fail.
  let col = matchend(line, '^\s*[]})]')
  if col > 0 && !s:IsInStringOrComment(v:lnum, col)
    call cursor(v:lnum, col)
    let bs = strpart('(){}[]', stridx(')}]', line[col - 1]) * 2, 2)
    if searchpair(escape(bs[0], '\['), '', bs[1], 'bW', s:skip_expr) > 0
      if line[col-1]==')' && col('.') != col('$') - 1
	let ind = virtcol('.')-1
      else
	let ind = indent(s:GetMSL(line('.')))
      endif
    endif
    return ind
  endif

  " If we have a =begin or =end set indent to first column.
  if match(line, '^\s*\%(=begin\|=end\)$') != -1
    return 0
  endif

  " If we have a deindenting keyword, find its match and indent to its level.
  " TODO: this is messy
  if s:Match(v:lnum, s:ruby_deindent_keywords)
    call cursor(v:lnum, 1)
    if searchpair(s:end_start_regex, s:end_middle_regex, s:end_end_regex, 'bW',
	    \ s:end_skip_expr) > 0
      let line = getline('.')
      if strpart(line, 0, col('.') - 1) =~ '=\s*$' &&
       \ strpart(line, col('.') - 1, 2) !~ 'do'
	let ind = virtcol('.') - 1
      else
	let ind = indent('.')
      endif
    endif
    return ind
  endif

  " If we are in a multi-line string or line-comment, don't do anything to it.
  if s:IsInStringOrDocumentation(v:lnum, matchend(line, '^\s*') + 1)
    return indent('.')
  endif

  " 3.3. Work on the previous line. {{{2
  " -------------------------------

  " Find a non-blank, non-multi-line string line above the current line.
  let lnum = s:PrevNonBlankNonString(v:lnum - 1)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " Set up variables for current line.
  let line = getline(lnum)
  let ind = indent(lnum)

  " If the previous line ended with a block opening, add a level of indent.
  if s:Match(lnum, s:block_regex)
    return indent(s:GetMSL(lnum)) + &sw
  endif

  " If the previous line contained an opening bracket, and we are still in it,
  " add indent depending on the bracket type.
  if line =~ '[[({]'
    let counts = s:LineHasOpeningBrackets(lnum)
    if counts[0] == '1' && searchpair('(', '', ')', 'bW', s:skip_expr) > 0
      if col('.') + 1 == col('$')
	return ind + &sw
      else
	return virtcol('.')
      endif
    elseif counts[1] == '1' || counts[2] == '1'
      return ind + &sw
    else
      call cursor(v:lnum, vcol)
    end
  endif

  " If the previous line ended with an "end", match that "end"s beginning's
  " indent.
  let col = s:Match(lnum, '\%(^\|[^.:@$]\)\<end\>\s*\%(#.*\)\=$')
  if col > 0
    call cursor(lnum, col)
    if searchpair(s:end_start_regex, '', s:end_end_regex, 'bW',
		\ s:end_skip_expr) > 0
      let n = line('.')
      let ind = indent('.')
      let msl = s:GetMSL(n)
      if msl != n
	let ind = indent(msl)
      end
      return ind
    endif
  end

  let col = s:Match(lnum, s:ruby_indent_keywords)
  if col > 0
    call cursor(lnum, col)
    let ind = virtcol('.') - 1 + &sw
"    let ind = indent(lnum) + &sw
    " TODO: make this better (we need to count them) (or, if a searchpair
    " fails, we know that something is lacking an end and thus we indent a
    " level
    if s:Match(lnum, s:end_end_regex)
      let ind = indent('.')
    endif
    return ind
  endif

  " 3.4. Work on the MSL line. {{{2
  " --------------------------

  " Set up variables to use and search for MSL to the previous line.
  let p_lnum = lnum
  let lnum = s:GetMSL(lnum)

  " If the previous line wasn't a MSL and is continuation return its indent.
  " TODO: the || s:IsInString() thing worries me a bit.
  if p_lnum != lnum
    if s:Match(p_lnum,s:continuation_regex)||s:IsInString(p_lnum,strlen(line))
      return ind
    endif
  endif

  " Set up more variables, now that we know we wasn't continuation bound.
  let line = getline(lnum)
  let msl_ind = indent(lnum)

  " If the MSL line had an indenting keyword in it, add a level of indent.
  " TODO: this does not take into account contrived things such as
  " module Foo; class Bar; end
  if s:Match(lnum, s:ruby_indent_keywords)
    let ind = msl_ind + &sw
    if s:Match(lnum, s:end_end_regex)
      let ind = ind - &sw
    endif
    return ind
  endif

  " If the previous line ended with [*+/.-=], indent one extra level.
  if s:Match(lnum, s:continuation_regex)
    if lnum == p_lnum
      let ind = msl_ind + &sw
    else
      let ind = msl_ind
    endif
  endif

  " }}}2

  return ind
endfunction

" }}}1

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet ff=unix:
syntax/eruby.vim
85
" Vim syntax file
" Language:		eRuby
" Maintainer:		Tim Pope <vimNOSPAM@tpope.info>
" Info:			$Id: eruby.vim,v 1.18 2007/05/06 23:56:12 tpope Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'eruby'
endif

if !exists("g:eruby_default_subtype")
  let g:eruby_default_subtype = "html"
endif

if !exists("b:eruby_subtype") && main_syntax == 'eruby'
  let s:lines = getline(1)."\n".getline(2)."\n".getline(3)."\n".getline(4)."\n".getline(5)."\n".getline("$")
  let b:eruby_subtype = matchstr(s:lines,'eruby_subtype=\zs\w\+')
  if b:eruby_subtype == ''
    let b:eruby_subtype = matchstr(substitute(expand("%:t"),'\c\%(\.erb\)\+$','',''),'\.\zs\w\+$')
  endif
  if b:eruby_subtype == 'rhtml'
    let b:eruby_subtype = 'html'
  elseif b:eruby_subtype == 'rb'
    let b:eruby_subtype = 'ruby'
  elseif b:eruby_subtype == 'yml'
    let b:eruby_subtype = 'yaml'
  elseif b:eruby_subtype == 'js'
    let b:eruby_subtype = 'javascript'
  elseif b:eruby_subtype == 'txt'
    " Conventional; not a real file type
    let b:eruby_subtype = 'text'
  elseif b:eruby_subtype == ''
    let b:eruby_subtype = g:eruby_default_subtype
  endif
endif

if !exists("b:eruby_nest_level")
  let b:eruby_nest_level = strlen(substitute(substitute(substitute(expand("%:t"),'@','','g'),'\c\.\%(erb\|rhtml\)\>','@','g'),'[^@]','','g'))
endif
if !b:eruby_nest_level
  let b:eruby_nest_level = 1
endif

if exists("b:eruby_subtype") && b:eruby_subtype != ''
  exe "runtime! syntax/".b:eruby_subtype.".vim"
  unlet! b:current_syntax
endif
syn include @rubyTop syntax/ruby.vim

syn cluster erubyRegions contains=erubyOneLiner,erubyBlock,erubyExpression,erubyComment

exe 'syn region  erubyOneLiner   matchgroup=erubyDelimiter start="^%\{1,'.b:eruby_nest_level.'\}%\@!"    end="$"     contains=@rubyTop	     containedin=ALLBUT,@erbRegions keepend oneline'
exe 'syn region  erubyBlock      matchgroup=erubyDelimiter start="<%\{1,'.b:eruby_nest_level.'\}%\@!-\=" end="-\=%>" contains=@rubyTop	     containedin=ALLBUT,@erbRegions'
exe 'syn region  erubyExpression matchgroup=erubyDelimiter start="<%\{1,'.b:eruby_nest_level.'\}="       end="-\=%>" contains=@rubyTop	     containedin=ALLBUT,@erbRegions'
exe 'syn region  erubyComment    matchgroup=erubyDelimiter start="<%\{1,'.b:eruby_nest_level.'\}#"       end="-\=%>" contains=rubyTodo,@Spell containedin=ALLBUT,@erbRegions keepend'

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_eruby_syntax_inits")
  if version < 508
    let did_ruby_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink erubyDelimiter		Delimiter
  HiLink erubyComment		Comment

  delcommand HiLink
endif
let b:current_syntax = 'eruby'

if main_syntax == 'eruby'
  unlet main_syntax
endif

" vim: nowrap sw=2 sts=2 ts=8 ff=unix:
syntax/ruby.vim
324
" Vim syntax file
" Language:		Ruby
" Maintainer:		Doug Kearns <dougkearns@gmail.com>
" Info:			$Id: ruby.vim,v 1.134 2007/05/06 17:55:04 tpope Exp $
" URL:			http://vim-ruby.rubyforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>
" ----------------------------------------------------------------------------
"
" Previous Maintainer:	Mirko Nasato
" Thanks to perl.vim authors, and to Reimer Behrends. :-) (MN)
" ----------------------------------------------------------------------------

if exists("b:current_syntax")
  finish
endif

if has("folding") && exists("ruby_fold")
  setlocal foldmethod=syntax
endif

if exists("ruby_space_errors")
  if !exists("ruby_no_trail_space_error")
    syn match rubySpaceError display excludenl "\s\+$"
  endif
  if !exists("ruby_no_tab_space_error")
    syn match rubySpaceError display " \+\t"me=e-1
  endif
endif

" Operators
if exists("ruby_operators")
  syn match  rubyOperator	 "\%([~!^&|*/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\*\*\|\.\.\.\|\.\.\|::\)"
  syn match  rubyPseudoOperator  "\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"
  syn region rubyBracketOperator matchgroup=rubyOperator start="\%([_[:lower:]]\w*[?!=]\=\|[})]\)\@<=\[\s*" end="\s*]" contains=TOP
endif

" Expression Substitution and Backslash Notation
syn match rubyEscape	"\\\\\|\\[abefnrstv]\|\\\o\{1,3}\|\\x\x\{1,2}"							 contained display
syn match rubyEscape	"\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)" contained display

syn region rubyInterpolation	      matchgroup=rubyInterpolationDelimiter start="#{" end="}" contained contains=TOP
syn match  rubyInterpolation	      "#\%(\$\|@@\=\)\w\+"    display contained  contains=rubyInterpolationDelimiter,rubyInstanceVariable,rubyClassVariable,rubyGlobalVariable,rubyPredefinedVariable
syn match  rubyInterpolationDelimiter "#\ze\%(\$\|@@\=\)\w\+" display contained
syn match  rubyInterpolation	      "#\$\%(-\w\|\W\)"       display contained  contains=rubyInterpolationDelimiter,rubyPredefinedVariable,rubyInvalidVariable
syn match  rubyInterpolationDelimiter "#\ze\$\%(-\w\|\W\)"    display contained
syn region rubyNoInterpolation	      start="\\#{" end="}"    contained
syn match  rubyNoInterpolation	      "\\#{"		      display contained
syn match  rubyNoInterpolation	      "\\#\%(\$\|@@\=\)\w\+"  display contained
syn match  rubyNoInterpolation	      "\\#\$\W"               display contained

syn match rubyDelimEscape	"\\[(<{\[)>}\]]" transparent display contained contains=NONE

syn region rubyNestedParentheses	start="("	end=")"		skip="\\\\\|\\)"	transparent contained contains=@rubyStringSpecial,rubyNestedParentheses,rubyDelimEscape
syn region rubyNestedCurlyBraces	start="{"	end="}"		skip="\\\\\|\\}"	transparent contained contains=@rubyStringSpecial,rubyNestedCurlyBraces,rubyDelimEscape
syn region rubyNestedAngleBrackets	start="<"	end=">"		skip="\\\\\|\\>"	transparent contained contains=@rubyStringSpecial,rubyNestedAngleBrackets,rubyDelimEscape
if exists("ruby_operators")
  syn region rubyNestedSquareBrackets	start="\["	end="\]"	skip="\\\\\|\\\]"	transparent contained contains=@rubyStringSpecial,rubyNestedSquareBrackets,rubyDelimEscape
else
  syn region rubyNestedSquareBrackets	start="\["	end="\]"	skip="\\\\\|\\\]"	transparent containedin=rubyArrayLiteral contained contains=@rubyStringSpecial,rubyNestedSquareBrackets,rubyDelimEscape
endif

syn cluster rubyStringSpecial		contains=rubyInterpolation,rubyNoInterpolation,rubyEscape
syn cluster rubyExtendedStringSpecial	contains=@rubyStringSpecial,rubyNestedParentheses,rubyNestedCurlyBraces,rubyNestedAngleBrackets,rubyNestedSquareBrackets

" Numbers and ASCII Codes
syn match rubyASCIICode	"\%(\w\|[]})\"'/]\)\@<!\%(?\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\=\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)\)"
syn match rubyInteger	"\<0[xX]\x\+\%(_\x\+\)*\>"								display
syn match rubyInteger	"\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)\>"						display
syn match rubyInteger	"\<0[oO]\=\o\+\%(_\o\+\)*\>"								display
syn match rubyInteger	"\<0[bB][01]\+\%(_[01]\+\)*\>"								display
syn match rubyFloat	"\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*\>"					display
syn match rubyFloat	"\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>"	display

" Identifiers
syn match rubyLocalVariableOrMethod "\<[_[:lower:]][_[:alnum:]]*[?!=]\=" contains=NONE display transparent
syn match rubyBlockArgument	    "&[_[:lower:]][_[:alnum:]]"		 contains=NONE display transparent

syn match  rubyConstant			"\%(\%([.@$]\@<!\.\)\@<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=\%(\s*(\)\@!"
syn match  rubyClassVariable		"@@\h\w*" display
syn match  rubyInstanceVariable		"@\h\w*"  display
syn match  rubyGlobalVariable		"$\%(\h\w*\|-.\)"
syn match  rubySymbol			"[]})\"':]\@<!:\%(\^\|\~\|<<\|<=>\|<=\|<\|===\|==\|=\~\|>>\|>=\|>\||\|-@\|-\|/\|\[]=\|\[]\|\*\*\|\*\|&\|%\|+@\|+\|`\)"
syn match  rubySymbol			"[]})\"':]\@<!:\$\%(-.\|[`~<=>_,;:!?/.'"@$*\&+0]\)"
syn match  rubySymbol			"[]})\"':]\@<!:\%(\$\|@@\=\)\=\h\w*"
syn match  rubySymbol			"[]})\"':]\@<!:\h\w*[?!=]\="
syn region rubySymbol			start="[]})\"':]\@<!:\"" end="\"" skip="\\\\\|\\\""
syn region rubySymbol			start="[]})\"':]\@<!:\"" end="\"" skip="\\\\\|\\\"" contains=@rubyStringSpecial fold

syn match  rubyBlockParameter		"\h\w*" contained
syn region rubyBlockParameterList	start="\%(\%(\<do\>\|{\)\s*\)\@<=|" end="|" oneline display contains=rubyBlockParameter

syn match rubyInvalidVariable    "$[^ A-Za-z-]"
syn match rubyPredefinedVariable #$[!$&"'*+,./0:;<=>?@\`~1-9]#
syn match rubyPredefinedVariable "$_\>"											   display
syn match rubyPredefinedVariable "$-[0FIKadilpvw]\>"									   display
syn match rubyPredefinedVariable "$\%(deferr\|defout\|stderr\|stdin\|stdout\)\>"					   display
syn match rubyPredefinedVariable "$\%(DEBUG\|FILENAME\|KCODE\|LOADED_FEATURES\|LOAD_PATH\|PROGRAM_NAME\|SAFE\|VERBOSE\)\>" display
syn match rubyPredefinedConstant "\%(\%(\.\@<!\.\)\@<!\|::\)\_s*\zs\%(MatchingData\|ARGF\|ARGV\|ENV\)\>\%(\s*(\)\@!"
syn match rubyPredefinedConstant "\%(\%(\.\@<!\.\)\@<!\|::\)\_s*\zs\%(DATA\|FALSE\|NIL\|RUBY_PLATFORM\|RUBY_RELEASE_DATE\)\>\%(\s*(\)\@!"
syn match rubyPredefinedConstant "\%(\%(\.\@<!\.\)\@<!\|::\)\_s*\zs\%(RUBY_VERSION\|STDERR\|STDIN\|STDOUT\|TOPLEVEL_BINDING\|TRUE\)\>\%(\s*(\)\@!"
"Obsolete Global Constants
"syn match rubyPredefinedConstant "\%(::\)\=\zs\%(PLATFORM\|RELEASE_DATE\|VERSION\)\>"
"syn match rubyPredefinedConstant "\%(::\)\=\zs\%(NotImplementError\)\>"

" Normal Regular Expression
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="\%(\%(^\|\<\%(and\|or\|while\|until\|unless\|if\|elsif\|when\|not\|then\|else\)\|[;\~=!|&(,[>]\)\s*\)\@<=/" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@rubyStringSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="\%(\<\%(split\|scan\|gsub\|sub\)\s*\)\@<=/" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@rubyStringSpecial fold

" Normal String and Shell Command Output
syn region rubyString matchgroup=rubyStringDelimiter start="\"" end="\"" skip="\\\\\|\\\"" contains=@rubyStringSpecial fold
syn region rubyString matchgroup=rubyStringDelimiter start="'"	end="'"  skip="\\\\\|\\'"			       fold
syn region rubyString matchgroup=rubyStringDelimiter start="`"	end="`"  skip="\\\\\|\\`"  contains=@rubyStringSpecial fold

" Generalized Regular Expression
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)"	end="\z1[iomxneus]*" skip="\\\\\|\\\z1" contains=@rubyStringSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r{"				end="}[iomxneus]*"	 skip="\\\\\|\\}"   contains=@rubyStringSpecial,rubyNestedCurlyBraces,rubyDelimEscape fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r<"				end=">[iomxneus]*"	 skip="\\\\\|\\>"   contains=@rubyStringSpecial,rubyNestedAngleBrackets,rubyDelimEscape fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r\["				end="\][iomxneus]*"	 skip="\\\\\|\\\]"  contains=@rubyStringSpecial,rubyNestedSquareBrackets,rubyDelimEscape fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r("				end=")[iomxneus]*"	 skip="\\\\\|\\)"   contains=@rubyStringSpecial,rubyNestedParentheses,rubyDelimEscape fold

" Generalized Single Quoted String, Symbol and Array of Strings
syn region rubyString matchgroup=rubyStringDelimiter start="%[qw]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)"  end="\z1" skip="\\\\\|\\\z1" fold
syn region rubyString matchgroup=rubyStringDelimiter start="%[qw]{"				    end="}"   skip="\\\\\|\\}"	 fold	contains=rubyNestedCurlyBraces,rubyDelimEscape
syn region rubyString matchgroup=rubyStringDelimiter start="%[qw]<"				    end=">"   skip="\\\\\|\\>"	 fold	contains=rubyNestedAngleBrackets,rubyDelimEscape
syn region rubyString matchgroup=rubyStringDelimiter start="%[qw]\["				    end="\]"  skip="\\\\\|\\\]"	 fold	contains=rubyNestedSquareBrackets,rubyDelimEscape
syn region rubyString matchgroup=rubyStringDelimiter start="%[qw]("				    end=")"   skip="\\\\\|\\)"	 fold	contains=rubyNestedParentheses,rubyDelimEscape
syn region rubySymbol				     start="%[s]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)"   end="\z1" skip="\\\\\|\\\z1" fold
syn region rubySymbol				     start="%[s]{"				    end="}"   skip="\\\\\|\\}"	 fold	contains=rubyNestedCurlyBraces,rubyDelimEscape
syn region rubySymbol				     start="%[s]<"				    end=">"   skip="\\\\\|\\>"	 fold	contains=rubyNestedAngleBrackets,rubyDelimEscape
syn region rubySymbol				     start="%[s]\["				    end="\]"  skip="\\\\\|\\\]"	 fold	contains=rubyNestedSquareBrackets,rubyDelimEscape
syn region rubySymbol				     start="%[s]("				    end=")"   skip="\\\\\|\\)"	 fold	contains=rubyNestedParentheses,rubyDelimEscape

" Generalized Double Quoted String and Array of Strings and Shell Command Output
" Note: %= is not matched here as the beginning of a double quoted string
syn region rubyString matchgroup=rubyStringDelimiter start="%\z([~`!@#$%^&*_\-+|\:;"',.?/]\)"	    end="\z1" skip="\\\\\|\\\z1" contains=@rubyStringSpecial fold
syn region rubyString matchgroup=rubyStringDelimiter start="%[QWx]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)" end="\z1" skip="\\\\\|\\\z1" contains=@rubyStringSpecial fold
syn region rubyString matchgroup=rubyStringDelimiter start="%[QWx]\={"				    end="}"   skip="\\\\\|\\}"	 contains=@rubyStringSpecial,rubyNestedCurlyBraces,rubyDelimEscape fold
syn region rubyString matchgroup=rubyStringDelimiter start="%[QWx]\=<"				    end=">"   skip="\\\\\|\\>"	 contains=@rubyStringSpecial,rubyNestedAngleBrackets,rubyDelimEscape fold
syn region rubyString matchgroup=rubyStringDelimiter start="%[QWx]\=\["				    end="\]"  skip="\\\\\|\\\]"	 contains=@rubyStringSpecial,rubyNestedSquareBrackets,rubyDelimEscape fold
syn region rubyString matchgroup=rubyStringDelimiter start="%[QWx]\=("				    end=")"   skip="\\\\\|\\)"	 contains=@rubyStringSpecial,rubyNestedParentheses,rubyDelimEscape fold

" Here Document
syn region rubyHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs\%(\h\w*\)+   end=+$+ oneline contains=TOP
syn region rubyHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs"\%([^"]*\)"+ end=+$+ oneline contains=TOP
syn region rubyHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs'\%([^']*\)'+ end=+$+ oneline contains=TOP
syn region rubyHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs`\%([^`]*\)`+ end=+$+ oneline contains=TOP

syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<\z(\h\w*\)\ze+hs=s+2    matchgroup=rubyStringDelimiter end=+^\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend
syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<"\z([^"]*\)"\ze+hs=s+2  matchgroup=rubyStringDelimiter end=+^\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend
syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<'\z([^']*\)'\ze+hs=s+2  matchgroup=rubyStringDelimiter end=+^\z1$+ contains=rubyHeredocStart		      fold keepend
syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<`\z([^`]*\)`\ze+hs=s+2  matchgroup=rubyStringDelimiter end=+^\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend

syn region rubyString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-\z(\h\w*\)\ze+hs=s+3    matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend
syn region rubyString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-"\z([^"]*\)"\ze+hs=s+3  matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend
syn region rubyString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-'\z([^']*\)'\ze+hs=s+3  matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart		     fold keepend
syn region rubyString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-`\z([^`]*\)`\ze+hs=s+3  matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend

if exists('main_syntax') && main_syntax == 'eruby'
  let b:ruby_no_expensive = 1
end

syn match  rubyAliasDeclaration    "[^[:space:];#.()]\+"  contained contains=rubySymbol,rubyGlobalVariable,rubyPredefinedVariable nextgroup=rubyAliasDeclaration2 skipwhite
syn match  rubyAliasDeclaration2   "[^[:space:];#.()]\+"  contained contains=rubySymbol,rubyGlobalVariable,rubyPredefinedVariable
syn match  rubyMethodDeclaration   "[^[:space:];#(]\+"	  contained contains=rubyConstant,rubyBoolean,rubyPseudoVariable,rubyInstanceVariable,rubyClassVariable,rubyGlobalVariable
syn match  rubyClassDeclaration    "[^[:space:];#<]\+"	  contained contains=rubyConstant
syn match  rubyModuleDeclaration   "[^[:space:];#]\+"	  contained contains=rubyConstant
syn match  rubyFunction "\<[_[:alpha:]][_[:alnum:]]*[?!=]\=[[:alnum:].:?!=]\@!" contained containedin=rubyMethodDeclaration
syn match  rubyFunction "\%(\s\|^\)\@<=[_[:alpha:]][_[:alnum:]]*[?!=]\=\%(\s\|$\)\@=" contained containedin=rubyAliasDeclaration,rubyAliasDeclaration2
syn match  rubyFunction "\%([[:space:].]\|^\)\@<=\%(\[\]=\=\|\*\*\|[+-]@\=\|[*/%|&^~]\|<<\|>>\|[<>]=\=\|<=>\|===\|==\|=\~\|`\)\%([[:space:];#(]\|$\)\@=" contained containedin=rubyAliasDeclaration,rubyAliasDeclaration2,rubyMethodDeclaration

" Expensive Mode - match 'end' with the appropriate opening keyword for syntax
" based folding and special highlighting of module/class/method definitions
if !exists("b:ruby_no_expensive") && !exists("ruby_no_expensive")
  syn match  rubyDefine "\<alias\>"		nextgroup=rubyAliasDeclaration	skipwhite skipnl
  syn match  rubyDefine "\<def\>"		nextgroup=rubyMethodDeclaration skipwhite skipnl
  syn match  rubyClass	"\<class\>"		nextgroup=rubyClassDeclaration	skipwhite skipnl
  syn match  rubyModule "\<module\>"		nextgroup=rubyModuleDeclaration skipwhite skipnl
  syn region rubyBlock start="\<def\>"		matchgroup=rubyDefine end="\%(\<def\_s\+\)\@<!\<end\>" contains=TOP fold
  syn region rubyBlock start="\<class\>"	matchgroup=rubyClass  end="\<end\>" contains=TOP fold
  syn region rubyBlock start="\<module\>"	matchgroup=rubyModule end="\<end\>" contains=TOP fold

  " modifiers
  syn match  rubyConditionalModifier "\<\%(if\|unless\)\>"   display
  syn match  rubyRepeatModifier	     "\<\%(while\|until\)\>" display

  syn region rubyDoBlock matchgroup=rubyControl start="\<do\>" end="\<end\>" contains=TOP fold
  " curly bracket block or hash literal
  syn region rubyCurlyBlock   start="{" end="}" contains=TOP fold
  syn region rubyArrayLiteral matchgroup=rubyArrayDelimiter start="\%(\w\|[\]})]\)\@<!\[" end="]" contains=TOP fold

  " statements without 'do'
  syn region rubyBlockExpression       matchgroup=rubyControl	  start="\<begin\>" end="\<end\>" contains=TOP fold
  syn region rubyCaseExpression	       matchgroup=rubyConditional start="\<case\>"  end="\<end\>" contains=TOP fold
  syn region rubyConditionalExpression matchgroup=rubyConditional start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+=-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!?]\)\s*\)\@<=\%(if\|unless\)\>" end="\<end\>" contains=TOP fold

  syn keyword rubyConditional then else when  contained containedin=rubyCaseExpression
  syn keyword rubyConditional then else elsif contained containedin=rubyConditionalExpression

  " statements with optional 'do'
  syn region rubyOptionalDoLine   matchgroup=rubyRepeat start="\<for\>" start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!=?]\)\s*\)\@<=\<\%(until\|while\)\>" matchgroup=rubyOptionalDo end="\%(\<do\>\)" end="\ze\%(;\|$\)" oneline contains=TOP
  syn region rubyRepeatExpression start="\<for\>" start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!=?]\)\s*\)\@<=\<\%(until\|while\)\>" matchgroup=rubyRepeat end="\<end\>" contains=TOP nextgroup=rubyOptionalDoLine fold

  if !exists("ruby_minlines")
    let ruby_minlines = 50
  endif
  exec "syn sync minlines=" . ruby_minlines

else
  syn match   rubyControl "\<def\>"	nextgroup=rubyMethodDeclaration skipwhite skipnl
  syn match   rubyControl "\<class\>"	nextgroup=rubyClassDeclaration	skipwhite skipnl
  syn match   rubyControl "\<module\>"	nextgroup=rubyModuleDeclaration skipwhite skipnl
  syn keyword rubyControl case begin do for if unless while until else elsif then when end
  syn keyword rubyKeyword alias
endif

" Keywords
" Note: the following keywords have already been defined:
" begin case class def do end for if module unless until while
syn keyword rubyControl		and break ensure in next not or redo rescue retry return
syn match   rubyOperator	"\<defined?" display
syn keyword rubyKeyword		super undef yield
syn keyword rubyBoolean		true false
syn keyword rubyPseudoVariable	nil self __FILE__ __LINE__
syn keyword rubyBeginEnd	BEGIN END

" Special Methods
if !exists("ruby_no_special_methods")
  syn keyword rubyAccess    public protected private
  syn keyword rubyAttribute attr attr_accessor attr_reader attr_writer
  syn match   rubyControl   "\<\%(exit!\|\%(abort\|at_exit\|exit\|fork\|loop\|trap\)\>\)"
  syn keyword rubyEval	    eval class_eval instance_eval module_eval
  syn keyword rubyException raise fail catch throw
  syn keyword rubyInclude   autoload extend include load require
  syn keyword rubyKeyword   callcc caller lambda proc
endif

" Comments and Documentation
syn match   rubySharpBang     "\%^#!.*" display
syn keyword rubyTodo	      FIXME NOTE TODO OPTIMIZE XXX contained
syn match   rubyComment       "#.*" contains=rubySharpBang,rubySpaceError,rubyTodo,@Spell
if !exists("ruby_no_comment_fold")
  syn region rubyMultilineComment start="\%(\%(^\s*#.*\n\)\@<!\%(^\s*#.*\n\)\)\%(\(^\s*#.*\n\)\{1,}\)\@=" end="\%(^\s*#.*\n\)\@<=\%(^\s*#.*\n\)\%(^\s*#\)\@!" contains=rubyComment transparent fold keepend
  syn region rubyDocumentation	  start="^=begin\ze\%(\s.*\)\=$" end="^=end\s*$" contains=rubySpaceError,rubyTodo,@Spell fold
else
  syn region rubyDocumentation	  start="^=begin\s*$" end="^=end\s*$" contains=rubySpaceError,rubyTodo,@Spell
endif

" Note: this is a hack to prevent 'keywords' being highlighted as such when called as methods with an explicit receiver
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(alias\|and\|begin\|break\|case\|class\|def\|defined\|do\|else\)\>"			transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(elsif\|end\|ensure\|false\|for\|if\|in\|module\|next\|nil\)\>"			transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(not\|or\|redo\|rescue\|retry\|return\|self\|super\|then\|true\)\>"			transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(undef\|unless\|until\|when\|while\|yield\|BEGIN\|END\|__FILE__\|__LINE__\)\>"	transparent contains=NONE

syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(abort\|at_exit\|attr\|attr_accessor\|attr_reader\)\>"	transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(attr_writer\|autoload\|callcc\|catch\|caller\)\>"		transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(eval\|class_eval\|instance_eval\|module_eval\|exit\)\>"	transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(extend\|fail\|fork\|include\|lambda\)\>"			transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(load\|loop\|private\|proc\|protected\)\>"			transparent contains=NONE
syn match rubyKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(public\|require\|raise\|throw\|trap\)\>"			transparent contains=NONE

" __END__ Directive
syn region rubyData matchgroup=rubyDataDirective start="^__END__$" end="\%$" fold

hi def link rubyClass			rubyDefine
hi def link rubyModule			rubyDefine
hi def link rubyDefine			Define
hi def link rubyFunction		Function
hi def link rubyConditional		Conditional
hi def link rubyConditionalModifier	rubyConditional
hi def link rubyRepeat			Repeat
hi def link rubyRepeatModifier		rubyRepeat
hi def link rubyOptionalDo		rubyRepeat
hi def link rubyControl			Statement
hi def link rubyInclude			Include
hi def link rubyInteger			Number
hi def link rubyASCIICode		Character
hi def link rubyFloat			Float
hi def link rubyBoolean			Boolean
hi def link rubyException		Exception
if !exists("ruby_no_identifiers")
  hi def link rubyIdentifier		Identifier
else
  hi def link rubyIdentifier		NONE
endif
hi def link rubyClassVariable		rubyIdentifier
hi def link rubyConstant		Type
hi def link rubyGlobalVariable		rubyIdentifier
hi def link rubyBlockParameter		rubyIdentifier
hi def link rubyInstanceVariable	rubyIdentifier
hi def link rubyPredefinedIdentifier	rubyIdentifier
hi def link rubyPredefinedConstant	rubyPredefinedIdentifier
hi def link rubyPredefinedVariable	rubyPredefinedIdentifier
hi def link rubySymbol			Constant
hi def link rubyKeyword			Keyword
hi def link rubyOperator		Operator
hi def link rubyPseudoOperator		rubyOperator
hi def link rubyBeginEnd		Statement
hi def link rubyAccess			Statement
hi def link rubyAttribute		Statement
hi def link rubyEval			Statement
hi def link rubyPseudoVariable		Constant

hi def link rubyComment			Comment
hi def link rubyData			Comment
hi def link rubyDataDirective		Delimiter
hi def link rubyDocumentation		Comment
hi def link rubyEscape			Special
hi def link rubyInterpolationDelimiter	Delimiter
hi def link rubyNoInterpolation		rubyString
hi def link rubySharpBang		PreProc
hi def link rubyRegexpDelimiter		rubyStringDelimiter
hi def link rubyStringDelimiter		Delimiter
hi def link rubyRegexp			rubyString
hi def link rubyString			String
hi def link rubyTodo			Todo

hi def link rubyInvalidVariable		Error
hi def link rubyError			Error
hi def link rubySpaceError		rubyError

let b:current_syntax = "ruby"

" vim: nowrap sw=2 sts=2 ts=8 noet ff=unix:
