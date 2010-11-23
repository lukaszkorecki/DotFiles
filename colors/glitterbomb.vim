" Vim color file
" Converted from Textmate theme GlitterBomb using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "GlitterBomb"

hi Cursor  guifg=NONE guibg=#ff0000 gui=NONE
hi Visual  guifg=NONE guibg=#5e5d5d gui=NONE
hi CursorLine  guifg=NONE guibg=#282828 gui=NONE
hi CursorColumn  guifg=NONE guibg=#242424 gui=NONE
hi LineNr  guifg=#6d6d6d guibg=#0b0a0a gui=NONE
hi VertSplit  guifg=#302f2f guibg=#302f2f gui=NONE
hi MatchParen  guifg=#dbb800 guibg=NONE gui=bold
hi StatusLine  guifg=#cfcfcf guibg=#302f2f gui=bold
hi StatusLineNC  guifg=#cfcfcf guibg=#302f2f gui=NONE
hi Pmenu  guifg=#e16521 guibg=NONE gui=bold
hi PmenuSel  guifg=NONE guibg=#5e5d5d gui=NONE
hi IncSearch  guifg=NONE guibg=#412221 gui=NONE
hi Search  guifg=NONE guibg=#412221 gui=NONE
hi Directory  guifg=#c0a368 guibg=NONE gui=NONE
hi Folded  guifg=#44444e guibg=#0b0a0a gui=NONE

hi Normal  guifg=#cfcfcf guibg=#0b0a0a gui=NONE
hi Boolean  guifg=#c0a368 guibg=NONE gui=NONE
hi Character  guifg=#c0a368 guibg=NONE gui=NONE
hi Comment  guifg=#44444e guibg=NONE gui=italic
hi Conditional  guifg=#dbb800 guibg=NONE gui=bold
hi Constant  guifg=#c0a368 guibg=NONE gui=NONE
hi Define  guifg=#dbb800 guibg=NONE gui=bold
hi ErrorMsg  guifg=#242424 guibg=#a3210c gui=NONE
hi WarningMsg  guifg=#242424 guibg=#a3210c gui=NONE
hi Float  guifg=#d3c788 guibg=NONE gui=NONE
hi Function  guifg=#e16521 guibg=NONE gui=bold
hi Identifier  guifg=#f6f080 guibg=NONE gui=NONE
hi Keyword  guifg=#dbb800 guibg=NONE gui=bold
hi Label  guifg=#4d6537 guibg=NONE gui=NONE
hi NonText  guifg=#484848 guibg=#242424 gui=NONE
hi Number  guifg=#d3c788 guibg=NONE gui=NONE
hi Operator  guifg=#988155 guibg=NONE gui=NONE
hi PreProc  guifg=#dbb800 guibg=NONE gui=bold
hi Special  guifg=#cfcfcf guibg=NONE gui=NONE
hi SpecialKey  guifg=#484848 guibg=#242424 gui=NONE
hi Statement  guifg=#dbb800 guibg=NONE gui=bold
hi StorageClass  guifg=#f6f080 guibg=NONE gui=NONE
hi String  guifg=#4d6537 guibg=NONE gui=NONE
hi Tag  guifg=#e16521 guibg=NONE gui=bold
hi Title  guifg=#cfcfcf guibg=NONE gui=bold
hi Todo  guifg=#44444e guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#e16521 guibg=NONE gui=bold
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#dbb800 guibg=NONE gui=bold
hi rubyFunction  guifg=#e16521 guibg=NONE gui=bold
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#c0a368 guibg=NONE gui=NONE
hi rubyConstant  guifg=#7d6c55 guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#4d6537 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#ae5251 guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#ae5251 guibg=NONE gui=NONE
hi rubyInclude  guifg=#dbb800 guibg=NONE gui=bold
hi rubyGlobalVariable  guifg=#ae5251 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#364627 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#364627 guibg=NONE gui=NONE
hi rubyEscape  guifg=#c0a368 guibg=NONE gui=NONE
hi rubyControl  guifg=#dbb800 guibg=NONE gui=bold
hi rubyClassVariable  guifg=#ae5251 guibg=NONE gui=NONE
hi rubyOperator  guifg=#988155 guibg=NONE gui=NONE
hi rubyException  guifg=#dbb800 guibg=NONE gui=bold
hi rubyPseudoVariable  guifg=#ae5251 guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#7d6c55 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#935e29 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#935e29 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#935e29 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#935e29 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#44444e guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#935e29 guibg=NONE gui=NONE
hi htmlTag  guifg=#aad7ef guibg=NONE gui=NONE
hi htmlEndTag  guifg=#aad7ef guibg=NONE gui=NONE
hi htmlTagName  guifg=#aad7ef guibg=NONE gui=NONE
hi htmlArg  guifg=#aad7ef guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#c0a368 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#f6f080 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#935e29 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#e16521 guibg=NONE gui=bold
hi yamlAnchor  guifg=#ae5251 guibg=NONE gui=NONE
hi yamlAlias  guifg=#ae5251 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#4d6537 guibg=NONE gui=NONE
hi cssURL  guifg=#ae5251 guibg=NONE gui=NONE
hi cssFunctionName  guifg=#935e29 guibg=NONE gui=NONE
hi cssColor  guifg=#c0a368 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#e16521 guibg=NONE gui=bold
hi cssClassName  guifg=#e16521 guibg=NONE gui=bold
hi cssValueLength  guifg=#d3c788 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#ebac47 guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
