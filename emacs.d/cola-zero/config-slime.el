(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/slime"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/slime/contrib"))
(require 'slime-autoloads)
(require 'slime-fancy)
(add-hook 'slime-load-hook (lambda ()
                             (require 'slime-fancy)))

(setq inferior-lisp-program "ccl")
(eval-after-load "slime"
   '(slime-setup '(slime-fancy slime-banner)))
(setq slime-net-coding-system 'utf-8-unix)
