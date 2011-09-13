;; darwin.el

;; brew
(add-to-list 'load-path "/usr/local/Cellar/emacs/23.3/share/emacs/site-lisp")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/local/sbin")

;; apel
(add-to-list 'load-path "/usr/local/Cellar/emacs/23.3a/share/emacs/site-lisp/apel")
(add-to-list 'load-path "/usr/local/Cellar/emacs/23.3a/share/emacs/site-lisp/emu")

(set-frame-parameter nil 'alpha 100)
(display-battery-mode t)

(setq x-select-enable-clipboard nil)
(setq x-select-enable-primary t)
(setq select-active-regions nil)

(setq mac-pass-control-to-system nil)
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; font
;; http://sakito.jp/emacs/emacs23.html#id15
;; (add-hook 'after-make-frame-functions
;;              '(lambda ()
;;                 (load "config/darwin-font.el")))
;;(if (featurep 'ns)
;;    (load "config/darwin-font.el"))
;; From: http://community.schemewiki.org/cgi-bin/scheme.cgi?Emacs
;; (and window-system
;;      (create-fontset-from-fontset-spec
;;       (concat
;;        "-apple-monaco-medium-r-normal--20-*-*-*-*-*-fontset-monaco,"
;;        "ascii:-apple-monaco-medium-r-normal--12-100-*-*-m-100-mac-roman,"
;;        "-apple-Hiragino_Kaku_Gothic_Pro-medium-normal-normal-*-*-*-*-*-p-0-iso10646-1"
;;        ))
;;      )


;; macにおけるIMEの設定
;; http://tezfm.blogspot.com/2009/11/cocoa-emacs.html
(if (eq window-system 'ns)
    (progn
      (set-language-environment "Japanese")
      (setq default-input-method "MacOSX")))

(menu-bar-mode 1)

;; http://www.emacswiki.org/emacs/ElDoc
(defadvice eldoc-highlight-function-argument
  (around my-formatting (sym args index) compile activate preactivate)
  "Replace original to apply my style of formatting."
  ;; HACK: intercept the call to eldoc-docstring-format-sym-doc at the
  ;; end of the adviced function. This is obviously brittle, but the
  ;; alternative approach of copy/pasting the original also has
  ;; downsides...
  (flet ((eldoc-docstring-format-sym-doc
	  (sym doc face)
	  (let* ((function-name (propertize (symbol-name sym)
					    'face face))
		 (spec (format "%s %s" function-name doc))
		 (docstring (or (eldoc-docstring-first-line
				 (documentation sym t))
				"Undocumented."))
		 (docstring (propertize docstring
					'face 'font-lock-doc-face))
		 ;; TODO: currently it strips from the start of spec by
		 ;; character instead of whole arguments at a time.
		 (fulldoc (format "%s: %s" spec docstring))
		 (ea-width (1- (window-width (minibuffer-window)))))
	    (cond ((or (<= (length fulldoc) ea-width)
		       (eq eldoc-echo-area-use-multiline-p t)
		       (and eldoc-echo-area-use-multiline-p
			    (> (length docstring) ea-width)))
		   fulldoc)
		  ((> (length docstring) ea-width)
		   (substring docstring 0 ea-width))
		  ((>= (- (length fulldoc) (length spec)) ea-width)
		   docstring)
		  (t
		   ;; Show the end of the partial symbol name, rather
		   ;; than the beginning, since the former is more likely
		   ;; to be unique given package namespace conventions.
		   (setq spec (substring spec (- (length fulldoc) ea-width)))
		   (format "%s: %s" spec docstring))))))
    ad-do-it))
