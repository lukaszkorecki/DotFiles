" Vim color file
" Converted from Textmate theme Blackboard Black using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Blackboard Black"

hi Cursor  guifg=NONE guibg=#b1b1b1 gui=NONE
hi Visual  guifg=NONE guibg=#253b76 gui=NONE
hi CursorLine  guifg=NONE guibg=#2a2a2a gui=NONE
hi CursorColumn  guifg=NONE guibg=#2a2a2a gui=NONE
hi LineNr  guifg=#8b8b8b guibg=#1f1f1f gui=NONE
hi VertSplit  guifg=#484848 guibg=#484848 gui=NONE
hi MatchParen  guifg=#fbde2d guibg=NONE gui=NONE
hi StatusLine  guifg=#f8f8f8 guibg=#484848 gui=bold
hi StatusLineNC  guifg=#f8f8f8 guibg=#484848 gui=NONE
hi Pmenu  guifg=#ff6400 guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#253b76 gui=NONE
hi IncSearch  guifg=NONE guibg=#693615 gui=NONE
hi Search  guifg=NONE guibg=#693615 gui=NONE
hi Directory  guifg=#d8fa3c guibg=NONE gui=NONE
hi Folded  guifg=#aeaeae guibg=#1f1f1f gui=NONE

hi Normal  guifg=#f8f8f8 guibg=#1f1f1f gui=NONE
hi Boolean  guifg=#d8fa3c guibg=NONE gui=NONE
hi Character  guifg=#d8fa3c guibg=NONE gui=NONE
hi Comment  guifg=#aeaeae guibg=NONE gui=NONE
hi Conditional  guifg=#fbde2d guibg=NONE gui=NONE
hi Constant  guifg=#d8fa3c guibg=NONE gui=NONE
hi Define  guifg=#fbde2d guibg=NONE gui=NONE
hi ErrorMsg  guifg=NONE guibg=NONE gui=NONE
hi WarningMsg  guifg=NONE guibg=NONE gui=NONE
hi Float  guifg=#d8fa3c guibg=NONE gui=NONE
hi Function  guifg=#ff6400 guibg=NONE gui=NONE
hi Identifier  guifg=#fbde2d guibg=NONE gui=NONE
hi Keyword  guifg=#fbde2d guibg=NONE gui=NONE
hi Label  guifg=#61ce3c guibg=NONE gui=NONE
hi NonText  guifg=#575757 guibg=#2a2a2a gui=NONE
hi Number  guifg=#d8fa3c guibg=NONE gui=NONE
hi Operator  guifg=#fbde2d guibg=NONE gui=NONE
hi PreProc  guifg=#fbde2d guibg=NONE gui=NONE
hi Special  guifg=#f8f8f8 guibg=NONE gui=NONE
hi SpecialKey  guifg=#575757 guibg=#2a2a2a gui=NONE
hi Statement  guifg=#fbde2d guibg=NONE gui=NONE
hi StorageClass  guifg=#fbde2d guibg=NONE gui=NONE
hi String  guifg=#61ce3c guibg=NONE gui=NONE
hi Tag  guifg=#ff6400 guibg=NONE gui=NONE
hi Title  guifg=#f8f8f8 guibg=NONE gui=bold
hi Todo  guifg=#aeaeae guibg=NONE gui=inverse,bold
hi Type  guifg=#ff6400 guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#fbde2d guibg=NONE gui=NONE
hi rubyFunction  guifg=#ff6400 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#d8fa3c guibg=NONE gui=NONE
hi rubyConstant  guifg=#8da6ce guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#61ce3c guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#fbde2d guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp  guifg=#61ce3c guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#61ce3c guibg=NONE gui=NONE
hi rubyEscape  guifg=#d8fa3c guibg=NONE gui=NONE
hi rubyControl  guifg=#fbde2d guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#fbde2d guibg=NONE gui=NONE
hi rubyException  guifg=#fbde2d guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#8da6ce guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#8da6ce guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#8da6ce guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#8da6ce guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#8da6ce guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#aeaeae guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#8da6ce guibg=NONE gui=NONE
hi htmlTag  guifg=#7f90aa guibg=NONE gui=NONE
hi htmlEndTag  guifg=#7f90aa guibg=NONE gui=NONE
hi htmlTagName  guifg=#7f90aa guibg=NONE gui=NONE
hi htmlArg  guifg=#7f90aa guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#d8fa3c guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#fbde2d guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#8da6ce guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#ff6400 guibg=NONE gui=NONE
hi yamlAnchor  guifg=NONE guibg=NONE gui=NONE
hi yamlAlias  guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#61ce3c guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#8da6ce guibg=NONE gui=NONE
hi cssColor  guifg=#d8fa3c guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#ff6400 guibg=NONE gui=NONE
hi cssClassName  guifg=#ff6400 guibg=NONE gui=NONE
hi cssValueLength  guifg=#d8fa3c guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#8da6ce guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
