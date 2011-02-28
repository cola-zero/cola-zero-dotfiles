(global-font-lock-mode 1)

(setenv "SBCL_HOME" (expand-file-name "~/opt/sbcl/lib/sbcl"))
(setq inferior-lisp-program (expand-file-name "~/opt/sbcl/bin/sbcl")
      slime-path (expand-file-name "~/lisp/slime/")
      w3m-command "/usr/local/bin/w3m"
      cltl2-url "file:///Users/masahirokoga/opt/doc/cltl/clm/node1.html"
      ;; hyperspec-prog (concat slime-path "hyperspec")
      hyperspec-path "/Users/masahirokoga/opt/doc/HyperSpec/")

;; settings for Common Lisp development:
(setq lisp-indent-function 'common-lisp-indent-function
      slime-startup-animation nil
      common-lisp-hyperspec-root (concat "file://" hyperspec-path)
      common-lisp-hyperspec-symbol-table (concat hyperspec-path "Data/Map_Sym.txt")
      w3m-default-homepage common-lisp-hyperspec-root
      ;; browse-url-browser-function 'w3m
      w3m-symbol 'w3m-default-symbol
      w3m-key-binding 'info
      w3m-coding-system 'utf-8
      w3m-default-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)
(add-to-list 'load-path slime-path)
(add-to-list 'load-path (concat slime-path "contrib"))
(require 'slime)
(require 'slime-editing-commands)
;; (add-hook 'slime-editing-commands)
(slime-setup)

;; (add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
