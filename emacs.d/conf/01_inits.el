; Packages conf code

; EVIL
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'evil)  
(evil-mode 1)

; Ack
(add-to-list 'load-path "~/.emacs.d/vendor/full-ack")
(require 'full-ack)  


; Speedbar-like-NERDtree
(require 'speedbar)
(require 'sr-speedbar)
