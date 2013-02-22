;(require 'clojure-test-mode)
;(require 'clojure-mode)

(eval-after-load "clojure-mode"
    '(progn
       (setq clojure-swank-command
             (if (or (locate-file "lein" exec-path) (locate-file "lein.bat" exec-path))
                 "lein ritz-in %s"
               "echo \"lein ritz-in %s\" | $SHELL -l"))


       (add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
       (defun my-nrepl-mode-setup ()
         (require 'nrepl-ritz))

       (add-hook 'clojure-mode-hook 'my-clojure-mode-setup)
       (defun my-clojure-mode-setup ()
         (nrepl-interaction-mode))

       (setq nrepl-ritz-javadoc-local-paths
             (list (concat (expand-file-name "~") "/opt/share/docs/java")))


       (define-clojure-indent
         (defroutes 'defun)
         (GET 2)
         (POST 2)
         (PUT 2)
         (DELETE 2)
         (HEAD 2)
         (ANY 2)
         (context 2))))

(provide 'config-clojure-mode)
