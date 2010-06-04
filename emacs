;;;
;;; .emacs
;;;

(setq inhibit-startup-message -1)


(add-to-list 'load-path "/home/koga/.emacs.d/auto-install/")
(add-to-list 'load-path "/home/koga/.emacs.d/site-lisp/")
(add-to-list 'load-path "/user/arch/koga/.emacs.d/auto-install/")
(add-to-list 'load-path "/user/arch/koga/.emacs.d/site-lisp/")
(add-to-list 'load-path "/user/arch/koga/.emacs.d/site-lisp/haskell-mode/")
(add-to-list 'load-path "/Users/masahiro/.emacs.d/site-lisp/")
(add-to-list 'load-path "/Users/masahiro/.emacs.d/auto-install/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/apel")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/autoconf")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/ddskk")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/dictionaries-common")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/elscreen")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-goodies-el")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/flim")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/semi")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/wl")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
(add-to-list 'load-path "/user/arch/koga/.emacs.d/ecb-2.40")
(add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/share/emacs/site-lisp/")

;get hostname
(setq hostname (system-name))
(if (null hostname)
    (setq hostname "no_host"))
; 小文字に
(setq hostname (downcase hostname))
; ピリオド以下削除(ピリオドがなければ変更なし)
(setq hostname (car (split-string hostname "\\.")))

;;font設定
(if (eq window-system 'w32)
  (load-file "~/.emacs-font-w32.el"))

;;ステータスバーの設定
(display-time-mode 1)
(line-number-mode 1)
(column-number-mode 1)

;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 100))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 100)

;; color-theme の設定
(when (require 'color-theme nil t)
      (if (not (string-match hostname "whale"))
	  (color-theme-initialize))
  (color-theme-gray30))

;長い行を折り返して表示
(setq trancate-partial-width-windows t)

;; ステータスラインに時間を表示する
(if (>= emacs-major-version 22)
    (progn
      (setq dayname-j-alist
	    '(("Sun" . "日") ("Mon" . "月") ("Tue" . "火") ("Wed" . "水")
	      ("Thu" . "木") ("Fri" . "金") ("Sat" . "土")))
      (setq display-time-string-forms
	    '((format "%s年%s月%s日(%s) %s:%s"
		      year month day
		      (cdr (assoc dayname dayname-j-alist))
		      24-hours minutes)))
))
(display-time)
(setq system-time-locale "C")
;visual-bell
(setq visible-bel t)

;行番号を表示
(line-number-mode t)

;タブ幅の設定
(setq default-tab-width 4)
;indentにtabだけを使う
(setq indent-tabs-mode nil)

;; major mode
(setq auto-mode-alist (append (list
			       '("\\.[ch]$" . c-mode)
			       '(".emacs" . emacs-lisp-mode)
			       '("\\.v" . verilog-mode)
				   '("\\.[hg]s"  . haskell-mode)
				   '("\\.hi"     . haskell-mode)
				   '("\\.hs"     . haskell-mode)
				   '("\\.l[hg]s" . literate-haskell-mode)
				   '("\\.el" . lisp-mode)
				   '("\\.lisp" . lisp-mode)
				   '("\\.org" . org-mode)
			       auto-mode-alist)))

;haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(require 'haskell-mode nil t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-program-name "c:/Program Files/Haskell Platform/2010.1.0.0/bin/ghci.exe")


;;
;; navi2ch
;;
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;; 行末にあるスペースを強調表示する
(when (boundp 'show-trailing-whitespace) (setq-default show-trailing-whitespace t))
(set-face-background 'trailing-whitespace "plum")
(set-face-underline 'trailing-whitespace t)

;; ツールバーを消す
 (tool-bar-mode -1)
;; メニューバーを消す
 (menu-bar-mode 1)


;;
;; git
;;
(require 'git nil t)

;;
;; wl
;;
; (if (require 'wanderlust-startup nil t)
;     (autoload 'wl "wl" "Wanderlust" t)
;     (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;     (autoload 'wo-draft "wl-draft" "Write draft with Wanderlust." t))

;;
;;anthy
;;
(set-language-environment "Japanese")
;; ; set load-path for anthy.el
;; (push "/usr/share/emacs/site-lisp/anthy/" load-path)
;; ; load anth.el
;; (load-library "anthy")
;; ; set default for japanese-anthy
;; (setq default-input-method "japanese-anthy")

;japanese
(when (or (string-match hostname "macbook")
		  (string-match hostname "debian" )
		  (string-match hostname "koga_dr" ))
  (prefer-coding-system 'utf-8))

;; enable color in console
(global-font-lock-mode t)


;;
;; TRAMP
;;
;; リモートのファイルを編集する
(require 'tramp nil t)

;;
;; multi-tty emacs
;;
(server-start)


;;
;; cscope
;;
(require 'xcscope nil t)

;; C-H を一文字前を削除に変更
;(define-key global-map "^H" 'backward-delete-char)
(define-key global-map "" 'backward-delete-char)

;; text-translator
;; http://d.hatena.ne.jp/khiker/20070503/emacs_text_translator
(require 'text-translator nil t)

(global-set-key "\C-xt" 'text-translator)
(global-set-key "\C-xT" 'test-translator-translate-last-string)

;; translate by using eijiro
(if (or (eq window-system 'w32)
		(eq window-system 'x))
	(progn
	  (setq sdic-eiwa-dictionary-list '((sdicf-client "~/.emacs.d/site-lisp/eedict.sdic")
										(sdicf-client "~/.emacs.d/site-lisp/gene.sdic")))
	  ;; (setq sdic-waei-dictionary-list '((sdicf-client "~/.emacs.d/site-lisp/eijirou.sdic")
	  ;; 									(sdicf-client "~/.emacs.d/site-lisp/waeijirou.sdic")))
	  (autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
	  (global-set-key "\C-cw" 'sdic-describe-word)
	  (autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
	  (global-set-key "\C-cW" 'sdic-describe-word-at-point)))

;;skk
(require 'skk-auto nil t)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(if (eq window-system 'w32)
	(setq skk-large-jisyo "~/AppData/Roaming/skkime/SKK-JISYO.L")
  (setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L"))



;elscreen
(require 'elscreen nil t)
(require 'elscreen-color-theme nil t)
(require 'elscreen-dired nil t)
(require 'elscreen-server nil t)

;howm
(setq howm-menu-lang 'ja)
(require 'howm-mode nil t)

;info
(require 'info nil t)

;anything
(require 'anything-config nil t)
(require 'anything-gtags nil t)
(require 'anything-search-file nil t)
(require 'resentf-ext nil t)
(require 'anything-include nil t)
(require 'anything-project nil t)
(setq anything-sources
      (list ;anything-c-source-gtags-select
			anything-c-source-include
			anything-c-source-buffers+
			anything-c-source-recentf
			anything-c-source-locate
			anything-c-source-files-in-current-dir
			anything-c-source-file-name-history
			anything-c-source-info-pages
			anything-c-source-info-elisp
			anything-c-source-man-pages
			anything-c-source-emacs-commands
			;; anything-c-source-find-files
			anything-c-source-file-cache
			anything-c-source-kill-ring
			anything-c-source-org-headline
			anything-c-source-elscreen
			anything-c-source-search-file))
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-c C-f") 'anything-project)
(define-key global-map (kbd "C-x b") 'anything-for-buffers)
(define-key global-map (kbd "C-;") 'anything)
;; (setq anything-gtags-hijack-gtags-select-mode nil) ;error回避

(require 'auto-install nil t)
(setq auto-install-update-emacswiki-package-name t)

;gtags
(require 'gtags nil t)
(setq c-mode-hook
      '(lambda ()
	 (gtags-mode 1)))
(setq gtags-mode-hook
      '(lambda ()
	 (local-set-key "\M-t" 'gtags-find-tag)
	 (local-set-key "\M-r" 'gtags-find-rtag)
	 (local-set-key "\M-s" 'gtags-find-symbol)
	 (local-set-key "\C-t" 'gtags-pop-stack)
	 ))

;;auto-complete
(require 'auto-complete-config nil t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)

;debug
(setq debug-on-error nil)

;org-mode
(load "~/.my-org-mode.el")

;C-F C-B C-P C-Nでウィンドウの移動
;http://d.hatena.ne.jp/authorNari/20091225/1261667956
;
(setq windmove-wrap-around t)
(define-key global-map [(C shift n)] 'windmove-down)
(define-key global-map [(C shift p)] 'windmove-up)
(define-key global-map [(C shift b)] 'windmove-left)
(define-key global-map [(C shift f)] 'windmove-right)

;uniquify
;http://nlp.kuee.kyoto-u.ac.jp/~shibata/mt/archives/000116.html
(require 'uniquify nil t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;twittering-mode
(require 'twittering-mode nil t)
(setq twittering-username "cola_zero")

;gdb
(setq gdb-many-windows t)
;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))
;;; I/O バッファを表示
(setq gdb-use-separate-io-buffer t)
;;; t にすると mini buffer に値が表示される
(setq gud-tooltip-echo-area nil)

(setq mac-pass-control-to-system nil)

;ruby-mode
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;ruby-electric
(require 'ruby-electric nil t)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block nil t)
;(ruby-block-mode t)
;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;; gccsence
(require 'gccsense)

;;c-eldoc.el
(load "c-eldoc")
(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-idle-delay) 0.20)
            (c-turn-on-eldoc-mode)
            ))
;; ispell
;; (setq ispell-dictionary "US-xlg")
;; (setq ispell-local-dictionary-alist
;;   '((nil				; default (english.aff)
;;      "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B") nil iso-8859-1)
;;     ("UK-xlg"				; english large version
;;      "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B" "-d" "UK-xlg") nil iso-8859-1)
;;     ("US-xlg"				; american large version
;;      "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B" "-d" "US-xlg") nil iso-8859-1)
;;    )
;; )

;;yatex mode
(if (eq window-system 'w32)
	(progn
	  (setq auto-mode-alist
			(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
      (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)))


;; 編集行を目立たせる
;; 【Emacs】 カーソル行のハイライト: 日々此精進
;; http://murakan.cocolog-nifty.com/blog/2009/01/emacs-tips-1d45.html
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "slate gray"))
    (((class color)
      (background light))
     (:background "slate gray"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)


(if (eq window-system 'ns)
	(progn
	  (define-key global-map [?¥] [?\\])
	  (define-key global-map [?\C-¥] [?\C-\\])
	  (define-key global-map [?\M-¥] [?\M-\\])
	  (define-key global-map [?\C-\M-¥] [?\C-\M-\\])))

;; slime
(setq inferior-lisp-program "sbcl")
(require 'slime nil t)
(slime-setup)
;;HyperSpec
(require 'hyperspec)
;; (setq common-lisp-hyperspec-root
;; 	  "file::///usr/share/doc/hyperspec/")
(setq common-lisp-hyperspec-root
	  "/usr/share/doc/hyperspec/"
	  common-lisp-hyperspec-symbol-table
	  "/usr/share/doc/hyperspec/Data/Map_Sym.txt")

;w3m
;(require 'w3m-load nil t)
;use w3m as browser in emacs;
(setq browse-url-browser-function 'w3m-browse-url)

;; lookup hyperspec by using w3m
(defadvice common-lisp-hyperspec
  (around hyperspec-lookup-w3m () activate)
  (let* ((window-configuration (current-window-configuration))
		 (brouse-url-browser-function
		  '(lamdba (url new-window)
				   (w3m-browse-url url nil)
				   (let ((hs-map (copy-keymap w3m-mode-map)))
					 (define-key hs-map (kbd "q")
					   (lambda ()
						 (interactive)
						 (kill-buffer nil)
						 (set-window-configuration ,window-configuration)))
					 (use-local-map hs-map)))))
    ad-do-it))

;use japanese
(setq slime-net-coding-system 'utf-8-unix)

;; auto display information
(slime-autodoc-mode)

(show-paren-mode)


(cd "~/")
