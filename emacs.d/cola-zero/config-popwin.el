;; popwin.el
;; https://github.com/m2ym/popwin-el
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages/popwin-el/misc"))
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;; anything
(setq anything-samewindow nil)
(add-to-list 'popwin:special-display-config '("*anything*" :height 20))
;; dired M-x dired-jump-other-window
(add-to-list 'popwin:special-display-config '(dired-mode :position top))
;; yatex
;; (require 'popwin-yatex)
;; (add-to-list 'popwin:special-display-config '(*YaTeX-typesetting*))
;; slime
(add-to-list 'popwin:special-display-config '("*slime-apropos*"))
(add-to-list 'popwin:special-display-config '("*slime-macroexpansion*"))
(add-to-list 'popwin:special-display-config '("*slime-description*"))
(add-to-list 'popwin:special-display-config '("*slime-compilation*" :noselect t))
(add-to-list 'popwin:special-display-config '("*slime-xref*"))
(add-to-list 'popwin:special-display-config '(sldb-mode :stick t))
(add-to-list 'popwin:special-display-config '(slime-repl-mode))
(add-to-list 'popwin:special-display-config '(slime-connection-list-mode))
(add-to-list 'popwin:special-display-config '(" *auto-async-byte-compile*" :noselect t))

(provide 'config-popwin)
