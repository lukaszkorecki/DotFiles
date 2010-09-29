" Vim color file
" Converted from Textmate theme Vibrant Tango using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Vibrant Tango"

hi Cursor  guifg=NONE guibg=#fbec50 gui=NONE
hi Visual  guifg=NONE guibg=#434441 gui=NONE
hi CursorLine  guifg=NONE guibg=#131413 gui=NONE
hi CursorColumn  guifg=NONE guibg=#131413 gui=NONE
hi LineNr  guifg=#8c8e8f guibg=#191d1e gui=NONE
hi VertSplit  guifg=#454849 guibg=#454849 gui=NONE
hi MatchParen  guifg=#f27709 guibg=NONE gui=NONE
hi StatusLine  guifg=#ffffff guibg=#454849 gui=bold
hi StatusLineNC  guifg=#ffffff guibg=#454849 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#434441 gui=NONE
hi IncSearch  guifg=NONE guibg=#613b17 gui=NONE
hi Search  guifg=NONE guibg=#613b17 gui=NONE
hi Directory  guifg=#739fcf guibg=NONE gui=NONE
hi Folded  guifg=#744e7b guibg=#191d1e gui=NONE

hi Normal  guifg=#ffffff guibg=#191d1e gui=NONE
hi Boolean  guifg=#739fcf guibg=NONE gui=NONE
hi Character  guifg=#739fcf guibg=NONE gui=NONE
hi Comment  guifg=#744e7b guibg=NONE gui=NONE
hi Conditional  guifg=#f27709 guibg=NONE gui=NONE
hi Constant  guifg=#739fcf guibg=NONE gui=NONE
hi Define  guifg=#f27709 guibg=NONE gui=NONE
hi ErrorMsg  guifg=NONE guibg=NONE gui=NONE
hi WarningMsg  guifg=NONE guibg=NONE gui=NONE
hi Float  guifg=#739fcf guibg=NONE gui=NONE
hi Function  guifg=#fbeb50 guibg=NONE gui=NONE
hi Identifier  guifg=NONE guibg=NONE gui=NONE
hi Keyword  guifg=#f27709 guibg=NONE gui=NONE
hi Label  guifg=#8de635 guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#131413 gui=NONE
hi Number  guifg=#739fcf guibg=NONE gui=NONE
hi Operator  guifg=#f27709 guibg=NONE gui=NONE
hi PreProc  guifg=#fbeb50 guibg=NONE gui=NONE
hi Special  guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#131413 gui=NONE
hi Statement  guifg=#f27709 guibg=NONE gui=NONE
hi StorageClass  guifg=NONE guibg=NONE gui=NONE
hi String  guifg=#8de635 guibg=NONE gui=NONE
hi Tag  guifg=NONE guibg=NONE gui=NONE
hi Title  guifg=#ffffff guibg=NONE gui=bold
hi Todo  guifg=#744e7b guibg=NONE gui=inverse,bold
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#f27709 guibg=NONE gui=NONE
hi rubyFunction  guifg=#fbeb50 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#739fcf guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#8de635 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#fbeb50 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#ffffff guibg=NONE gui=NONE
hi rubyRegexp  guifg=#739fcf guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#739fcf guibg=NONE gui=NONE
hi rubyEscape  guifg=#739fcf guibg=NONE gui=NONE
hi rubyControl  guifg=#f27709 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#f27709 guibg=NONE gui=NONE
hi rubyException  guifg=#fbeb50 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#e8b96f guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#e8b96f guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#744e7b guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#739fcf guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#fbeb50 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=NONE guibg=NONE gui=NONE
hi yamlAnchor  guifg=#ffffff guibg=NONE gui=NONE
hi yamlAlias  guifg=#ffffff guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#8de635 guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=NONE guibg=NONE gui=NONE
hi cssColor  guifg=#739fcf guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#f27709 guibg=NONE gui=NONE
hi cssClassName  guifg=#f27709 guibg=NONE gui=NONE
hi cssValueLength  guifg=#ffffff guibg=NONE gui=NONE
hi cssCommonAttr  guifg=NONE guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
