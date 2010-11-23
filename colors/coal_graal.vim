" Vim color file
" Converted from Textmate theme Coal Graal using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Coal Graal"

hi Cursor  guifg=NONE guibg=#d8d9d1 gui=NONE
hi Visual  guifg=NONE guibg=#6405d0 gui=NONE
hi CursorLine  guifg=NONE guibg=#282828 gui=NONE
hi CursorColumn  guifg=NONE guibg=#282828 gui=NONE
hi LineNr  guifg=#7d7e7a guibg=#222222 gui=NONE
hi VertSplit  guifg=#454543 guibg=#454543 gui=NONE
hi MatchParen  guifg=#a3aad8 guibg=NONE gui=NONE
hi StatusLine  guifg=#d8d9d1 guibg=#454543 gui=bold
hi StatusLineNC  guifg=#d8d9d1 guibg=#454543 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#6405d0 gui=NONE
hi IncSearch  guifg=NONE guibg=#4d4f5e gui=NONE
hi Search  guifg=NONE guibg=#4d4f5e gui=NONE
hi Directory  guifg=#dfca53 guibg=NONE gui=NONE
hi Folded  guifg=#b4df61 guibg=#222222 gui=NONE

hi Normal  guifg=#d8d9d1 guibg=#222222 gui=NONE
hi Boolean  guifg=#edb272 guibg=NONE gui=NONE
hi Character  guifg=#dfca53 guibg=NONE gui=NONE
hi Comment  guifg=#b4df61 guibg=NONE gui=NONE
hi Conditional  guifg=#a3aad8 guibg=NONE gui=NONE
hi Constant  guifg=NONE guibg=NONE gui=NONE
hi Define  guifg=#a3aad8 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#dfdfd5 guibg=#cc1b27 gui=NONE
hi WarningMsg  guifg=#dfdfd5 guibg=#cc1b27 gui=NONE
hi Float  guifg=#e4d962 guibg=NONE gui=NONE
hi Function  guifg=#dfcc94 guibg=NONE gui=NONE
hi Identifier  guifg=#dbbfed guibg=NONE gui=NONE
hi Keyword  guifg=#a3aad8 guibg=NONE gui=NONE
hi Label  guifg=#acc6d7 guibg=NONE gui=NONE
hi NonText  guifg=#e5e5b2 guibg=#282828 gui=NONE
hi Number  guifg=#e4d962 guibg=NONE gui=NONE
hi Operator  guifg=#a3aad8 guibg=NONE gui=NONE
hi PreProc  guifg=#a3aad8 guibg=NONE gui=NONE
hi Special  guifg=#d8d9d1 guibg=NONE gui=NONE
hi SpecialKey  guifg=#e5e5b2 guibg=#282828 gui=NONE
hi Statement  guifg=#a3aad8 guibg=NONE gui=NONE
hi StorageClass  guifg=#dbbfed guibg=NONE gui=NONE
hi String  guifg=#acc6d7 guibg=NONE gui=NONE
hi Tag  guifg=NONE guibg=NONE gui=NONE
hi Title  guifg=#d8d9d1 guibg=NONE gui=bold
hi Todo  guifg=#b4df61 guibg=NONE gui=inverse,bold
hi Type  guifg=#b998df guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#a3aad8 guibg=NONE gui=NONE
hi rubyFunction  guifg=#dfcc94 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#dfca53 guibg=NONE gui=NONE
hi rubyConstant  guifg=#a9a5d9 guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#acc6d7 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#85c6d9 guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#7ac0ed guibg=NONE gui=NONE
hi rubyInclude  guifg=#a3aad8 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#7ac0ed guibg=NONE gui=NONE
hi rubyRegexp  guifg=#acc6d7 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#acc6d7 guibg=NONE gui=NONE
hi rubyEscape  guifg=#dfca53 guibg=NONE gui=NONE
hi rubyControl  guifg=#a3aad8 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#a3aad8 guibg=NONE gui=NONE
hi rubyException  guifg=#a3aad8 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#7ac0ed guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#a9a5d9 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#d9c589 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#d9c589 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#d9c589 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#d9c589 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#b4df61 guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#d9c589 guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#dfca53 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#dbbfed guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#d9c589 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=NONE guibg=NONE gui=NONE
hi yamlAnchor  guifg=#7ac0ed guibg=NONE gui=NONE
hi yamlAlias  guifg=#7ac0ed guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#acc6d7 guibg=NONE gui=NONE
hi cssURL  guifg=#85c6d9 guibg=NONE gui=NONE
hi cssFunctionName  guifg=#d9c589 guibg=NONE gui=NONE
hi cssColor  guifg=#dfca53 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=NONE guibg=NONE gui=NONE
hi cssClassName  guifg=NONE guibg=NONE gui=NONE
hi cssValueLength  guifg=#e4d962 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=NONE guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE