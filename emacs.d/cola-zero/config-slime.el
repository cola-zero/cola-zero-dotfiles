;; (setq inferior-lisp-program "ccl")
;(require 'slime)
;; ;; (require 'slime-fuzzy)
;; (require 'slime-repl)
;;(require 'slime-fancy)
;; (slime-setup '(slime-repl slime-fuzzy))
;; (require 'slime-autoloads)
;; (require 'slime-fancy)
;; (add-hook 'slime-load-hook (lambda ()
;;                              (require 'slime-fancy)))

;; (eval-after-load "slime"
;;    '(slime-setup '(slime-fancy slime-banner)))
;; (setq slime-net-coding-system 'utf-8-unix)
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "sbcl")

(eval-after-load "slime"
  '(progn
     (let* ((ver  (package-version-join
                   (package-desc-vers (cdr (assq 'slime package-alist)))))
            (path (package--dir "slime" ver)))
       (add-to-list 'load-path (concat path "/contrib")))
     (require 'slime-fuzzy)
     (require 'slime-tramp)

     (push '(".*" #'convert-standard-filename #'identify)
           slime-filename-translations)
     (push (slime-create-filename-translator :machine-instance "presice64"
                                             :remote-host "presice64"
                                             :username "vagrant")
           slime-filename-translations)
     (slime-setup '(slime-fuzzy slime-tramp))))

;; ;; https://groups.google.com/forum/?fromgroups=#!topic/swank-clojure/av0vE-z54ZQ
;; (defun slime-tramp-local-filename (f)
;;   (interactive)
;;   (if (file-remote-p f)
;;       (tramp-file-name-localname
;;        (tramp-dissect-file-name f))
;;     f))

;; (defun slime-tramp-remote-filename (f)
;;   (interactive)
;;   (if (file-remote-p default-directory)
;;       (tramp-make-tramp-file-name
;;        (tramp-file-name-method
;;     (tramp-dissect-file-name default-directory))
;;        (tramp-file-name-user
;;     (tramp-dissect-file-name default-directory))
;;        (tramp-file-name-host
;;     (tramp-dissect-file-name default-directory))
;;        f)
;;     f))

;; (defun slime-remote-file-name-hook ()
;;   (interactive)
;;     (setq slime-from-lisp-filename-function
;;       'slime-tramp-remote-filename)
;;     (setq slime-to-lisp-filename-function
;;       'slime-tramp-local-filename))

;; (add-hook 'slime-connected-hook 'slime-remote-file-name-hook)



(provide 'config-slime)
