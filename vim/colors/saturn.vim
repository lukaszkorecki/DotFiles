" File: saturn.vim
" Author: Giacomo Comitti
" Description: Vim color file
" Last Modified: 01/07/2011
" Version: 0.1

" INITIAL SETUP
set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "saturn"

hi Normal           guifg=#969696   guibg=#202020

" VIM HIGHLIGHTING
hi  ColorColumn     guifg=NONE      guibg=#3A3A3A
hi  Cursor          guifg=bg        guibg=#fff000   gui=NONE
hi  CursorIM        guifg=bg        guibg=fg        gui=NONE
hi  CursorLine      guifg=NONE      guibg=#2a2a2a   gui=NONE
hi  lCursor         guifg=bg        guibg=fg        gui=NONE
hi  DiffAdd         guifg=#000000   guibg=#3cb371   gui=NONE
hi  DiffChange      guifg=#000000   guibg=#4f94cd   gui=NONE
hi  DiffDelete      guifg=#000000   guibg=#8b3626   gui=NONE
hi  DiffText        guifg=#000000   guibg=#8ee5ee   gui=NONE
hi  Directory       guifg=#1e90ff   guibg=bg        gui=NONE
hi  ErrorMsg        guifg=#ff6a6a   guibg=NONE      gui=bold
hi  FoldColumn      guifg=#68838b   guibg=#4B4B4B   gui=bold
hi  Folded          guifg=#68838b   guibg=#4B4B4B   gui=NONE
hi  IncSearch       guifg=#ffffff   guibg=#ff4500   gui=bold
hi  LineNr          guifg=#464646   guibg=bg        gui=NONE
hi  MatchParen      guifg=#fff000   guibg=#101010   gui=bold
hi  ModeMsg         guifg=#000000   guibg=#00ff00   gui=bold
hi  MoreMsg         guifg=#2e8b57   guibg=bg        gui=bold
hi  NonText         guifg=#9ac0cd   guibg=bg        gui=NONE
hi  Pmenu           guifg=#0000ff   guibg=#c0c8cf   gui=bold
hi  PmenuSel        guifg=#c0c8cf   guibg=#0000ff   gui=bold
hi  PmenuSbar       guifg=#ffffff   guibg=#c1cdc1   gui=NONE
hi  PmenuThumb      guifg=#ffffff   guibg=#838b83   gui=NONE
hi  Question        guifg=#fcfcfc   guibg=NONE      gui=bold
hi  Search          guifg=#000000   guibg=#ff88ee   gui=bold
hi  SignColumn      guifg=#ffffff   guibg=#cdcdb4   gui=NONE
hi  SpecialKey      guifg=#666666   guibg=NONE      gui=NONE
hi  StatusLine      guifg=#202020   guibg=#aaaaaa   gui=NONE
hi  StatusLineNC    guifg=#999999   guibg=#445566   gui=italic
hi  TabLine         guifg=fg        guibg=#d3d3d3   gui=underline
hi  TabLineFill     guifg=fg        guibg=bg        gui=reverse
hi  TabLineSel      guifg=fg        guibg=bg        gui=bold
hi  Title           guifg=#009acd   guibg=bg        gui=bold
hi  VertSplit       guifg=#445566   guibg=#445566
hi  Visual          guifg=#202020   guibg=#e177fc   gui=NONE
hi  WarningMsg      guifg=#ee9a00   guibg=bg        gui=NONE
hi  diffOldFile     guifg=#da70d6   guibg=NONE      gui=italic
hi  diffNewFile     guifg=#ffff00   guibg=NONE      gui=italic
hi  diffFile        guifg=#ffa500   guibg=NONE      gui=italic
hi  diffRemoved     guifg=#cd5555   guibg=NONE      gui=NONE
hi  diffChanged     guifg=#4f94cd   guibg=NONE      gui=NONE
hi  diffAdded       guifg=#00cd00   guibg=NONE      gui=NONE
hi  diffLine        guifg=#ff00ff   guibg=NONE      gui=italic
hi  WildMenu        guifg=#000000   guibg=#87ceeb   gui=NONE

" SYNTAX
hi  Comment         guifg=#559b70   guibg=NONE      gui=italic
hi  Constant        guifg=#e08562   guibg=NONE      gui=NONE
hi  String          guifg=#ab82ab   guibg=NONE      gui=NONE
hi  Boolean         guifg=#e08562   guibg=NONE      gui=NONE
hi  Identifier      guifg=#fdde73   guibg=NONE      gui=NONE 
hi  Function        guifg=#61fd38   guibg=NONE      gui=NONE
hi  Statement       guifg=#7a86cc   guibg=NONE      gui=NONE
hi  PreProc         guifg=#009acd   guibg=NONE      gui=NONE
hi  Keyword         guifg=#cccccc   guibg=NONE      gui=NONE
hi  Type            guifg=#cccccc   guibg=NONE      gui=NONE
hi  Special         guifg=#559b70   guibg=NONE      gui=NONE
hi  Ignore          guifg=bg        guibg=NONE      gui=NONE
hi  Error           guifg=#ff3030   guibg=NONE      gui=underline
hi  Todo            guifg=#ff88ee   guibg=NONE      gui=bold

if v:version >= 700
  if has('spell')
    hi SpellBad  	guifg=NONE	guibg=NONE	guisp=#c03000
    hi SpellCap	    guifg=NONE	guibg=NONE	guisp=#2060a8
    hi SpellRare	guifg=NONE	guibg=NONE	guisp=#a030a0
    hi SpellLocal	guifg=NONE	guibg=NONE	guisp=#007068
  endif
endif

" VIM
hi VimError         guifg=#ff6a6a   guibg=#101010   gui=bold
hi VimCommentTitle  guifg=#528b8b   guibg=bg        gui=bold,italic

" QuickFix
hi qfFileName       guifg=#607b8b   guibg=NONE      gui=italic
hi qfLineNr         guifg=#0088aa   guibg=NONE      gui=bold
hi qfError          guifg=#ff0000   guibg=NONE      gui=bold

" PYTHON
hi pythonDecorator  guifg=#7a86cc   guibg=NONE      gui=NONE
hi link pythonDecoratorFunction pythonDecorator
