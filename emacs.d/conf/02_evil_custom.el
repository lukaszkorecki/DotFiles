; Evil settings
(setq evil-auto-indent t)
(setq evil-fold-level 1)
(setq evil-shift-width 2)
(setq evil-word "[:word:]_@!?")
(setq evil-tabstop 2)
(setq evil-expand-tab t)
; ...and finally load evil
(require 'evil)  
(evil-mode 1)
