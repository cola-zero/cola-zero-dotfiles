;; cvs -d :pserver:anonymous:anonymous@common-lisp.net:/project/slime/cvsroot co slime
(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages/slime"))

;; (setenv "SBCL_HOME" (expand-file-name "~/opt/sbcl/lib/sbcl"))
(setq inferior-lisp-program (expand-file-name "~/opt/sbcl/bin/sbcl")
      slime-path (expand-file-name "~/lisp/slime/")
      w3m-command "/usr/local/bin/w3m"
      cltl2-url "file:///Users/masahirokoga/opt/doc/cltl/clm/node1.html"
      ;; hyperspec-prog (concat slime-path "hyperspec")
      hyperspec-path "/Users/masahirokoga/opt/doc/HyperSpec/")

(setq inferior-lisp-program (concat (expand-file-name "~/opt/bin/ccl")
                                    " -K utf-8"))
(setq slime-net-coding-system 'utf-8-unix)

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
(require 'slime nil t)
(require 'slime-editing-commands nil t)
;; (add-hook 'slime-editing-commands)
(slime-setup '(slime-fancy))

;; quicklisp
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))

;; (add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
