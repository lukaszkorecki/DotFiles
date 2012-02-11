; Packages conf code

; EVIL
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'evil)  
(evil-mode 1)

; Ack
(add-to-list 'load-path "~/.emacs.d/vendor/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)


; Speedbar-like-NERDtree
(require 'speedbar)
(require 'sr-speedbar)
