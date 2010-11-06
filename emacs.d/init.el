;;;
;;; .emacs.d/init.el
;;;
(setq inhibit-startup-message -1)

;; load-path
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/migemo")

;; do not make backup files
(setq make-backup-files nil)

;; auto-install
(require 'auto-install nil t)
(setq auto-install-update-emacswiki-package-name t)

;; anything
(require 'anything-startup nil t)
(define-key global-map (kbd "C-x b") 'anything-for-buffers)
(define-key global-map (kbd "C-x C-z") 'anything-execute-persistent-action)

;; get hostname
(setq hostname (system-name))
(if (null hostname)
    (setq hostname "no_host"))
;;  小文字に
(setq hostname (downcase hostname))
;;  ピリオド以下削除(ピリオドがなければ変更なし)
(setq hostname (car (split-string hostname "\\.")))

;; japanese
(when
    (or
     (string-match hostname "macbook")
     (string-match hostname "debian" )
     (string-match hostname "koga_dr" )
     (string-match hostname "whale"))
  (prefer-coding-system 'utf-8))
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; enable color in console
(global-font-lock-mode t)


;;font
;;http://yamashita.dyndns.org/blog/inconsolata-as-a-programming-font/
;(set-default-font "Inconsolata-11")
;; (set-face-font 'variable-pitch "Inconsolata-11")
(add-hook 'window-setup-hook
		  (lambda nil
            ;; font setting
			(set-default-font "Inconsolata-9")
			(set-face-font 'variable-pitch "Inconsolata-9")
			(set-fontset-font (frame-parameter nil 'font)
							  'japanese-jisx0208
							  '("Takaoゴシック" . "unicode-bmp")
							  )))

;;ステータスバーの設定
(display-time-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; color-theme の設定
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-katester))

;  (color-theme-charcoal-black))
;  (color-theme-gray30))

;; 長い行を折り返して表示
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
;; visual-bell
(setq visible-bel t)

;; 行番号を表示
(line-number-mode t)

;; タブ幅の設定
(setq default-tab-width 4)
;; indentにtabだけを使う
(setq indent-tabs-mode nil)

;; 行末にあるスペースを強調表示する
(when (boundp 'show-trailing-whitespace) (setq-default show-trailing-whitespace t))
(set-face-background 'trailing-whitespace "plum")
(set-face-underline 'trailing-whitespace t)

;; TRAMP
(require 'tramp nil t)

;; ;; skk-mode
;; (require 'skk-auto nil t)
;; (if (eq window-system 'w32)
;; 	(setq skk-large-jisyo "~/AppData/Roaming/skkime/SKK-JISYO.L")
;;   (setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L"))

;; ibus.el
;; (require 'ibus)
;; (add-hook 'after-init-hook 'ibus-mode-on)

;; ;; ibus-mozc
;; (ibus-define-common-key ?\C-j t)
;; (setq ibus-prediction-window-position t)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-mozc/")
(require 'mozc)  ; or (load-file "path-to-mozc.el")
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

;; emacs-daemon
(server-start)

;; elscreen
(require 'elscreen nil t)
(require 'elscreen-color-theme nil t)
(require 'elscreen-dired nil t)
(require 'elscreen-server nil t)

;; Google Chrome Edit with Emacs
(require 'edit-server)
(edit-server-start)


;; org-mode
(load "~/.emacs.d/my-org-mode.el")

;; C-F C-B C-P C-Nでウィンドウの移動
;; http://d.hatena.ne.jp/authorNari/20091225/1261667956
(setq windmove-wrap-around t)
(define-key global-map [(C shift n)] 'windmove-down)
(define-key global-map [(C shift p)] 'windmove-up)
(define-key global-map [(C shift b)] 'windmove-left)
(define-key global-map [(C shift f)] 'windmove-right)

;; uniquify
;; http://nlp.kuee.kyoto-u.ac.jp/~shibata/mt/archives/000116.html
(require 'uniquify nil t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; twittering-mode
(add-to-list 'load-path "~/work/twittering-mode/")
(require 'twittering-mode nil t)

;; web_browserをchromeに変更
;; http://d.hatena.ne.jp/suji_ski/20100710
(setq browse-url-browser-function
      '(("."        . browse-url-generic)))
(setq browse-url-generic-program "google-chrome")

;; (setq browse-url-browser-function 'w3m-browse-url
;;       browse-url-generic-program "/usr/bin/google-chrome")

;; 編集行を目立たせる
;; 【Emacs】 カーソル行のハイライト: 日々此精進
;; http://murakan.cocolog-nifty.com/blog/2009/01/emacs-tips-1d45.html
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "DarkSalmon"))
    (((class color)
      (background light))
     (:background "DarkSalmon"))
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

(if (eq window-system 'ns)
	(progn
	  (define-key global-map [?¥] [?\\])
	  (define-key global-map [?\C-¥] [?\C-\\])
	  (define-key global-map [?\M-¥] [?\M-\\])
	  (define-key global-map [?\C-\M-¥] [?\C-\M-\\])))

;; wandarlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; e2wm
;; 最小の e2wm 設定例
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
(require 'e2wm-config)
(require 'e2wm)
(global-set-key (kbd "M-+") 'e2wm:start-management)

;; term-mode
;; (add-hook 'term-mode-hook
;; 		  '(lambda ()
;; 			 (define-key term-raw-map "\C-p" 'previous-line)
;; 			 (define-key term-raw-map "\C-n" 'next-line)))
;; (add-to-list 'term-unbind-key-list '"M-x")

;; multi-term
;; http://sakito.jp/emacs/emacsshell.html#emacs-shell
;; curl -O http://www.emacswiki.org/emacs/download/multi-term.el
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
(require 'multi-term)
(setq milti-term-program shell-file-name)

;; indent with space
(setq-default indent-tabs-mode nil)

;; migemo
(load "migemo.el")
(setq migemo-command "/usr/bin/ruby")

;; auto-save-buffer.el
;;http://0xcc.net/misc/auto-save/
(require 'auto-save-buffers)
(run-with-idle-timer 0.5 t 'auto-save-buffers)

;; w3m
(setq w3m-use-cookies t)
(setq w3m-default-display-inline-images t)

;;
;; develop tool
;;

;; magit
(modify-coding-system-alist 'process "git" '(euc-jp-unix . utf-8-unix))


;; cscope
(require 'xcscope nil t)

;; gtags
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

;; gdb
(setq gdb-many-windows t)
;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))
;;; I/O バッファを表示
(setq gdb-use-separate-io-buffer t)
;;; t にすると mini buffer に値が表示される
(setq gud-tooltip-echo-area nil)

(setq mac-pass-control-to-system nil)


;; gccsence
(require 'gccsense nil t)

;;c-eldoc.el
(load "c-eldoc")
(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-idle-delay) 0.20)
            (c-turn-on-eldoc-mode)
            ))


;;yatex mode
(if (eq window-system 'w32)
	(progn
	  (setq auto-mode-alist
			(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
      (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)))

;; mode-compile.el
;; (autoload 'mode-compile "mode-compile"
;;  "Command to compile current buffer file based on the major mode" t)
;; (global-set-key "\C-cc" 'mode-compile)
;; (autoload 'mode-compile-kill "mode-compile"
;;  "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-ck" 'mode-compile-kill)

;; snippet
;;(require 'snippet nil t)


(require 'hatenahelper-mode nil t)

;; git-dwim
;; http://d.hatena.ne.jp/rubikitch/20100716/git
(require 'git-dwim nil t)
(global-set-key "\C-xvB" 'git-branch-next-action)

;; auto-complete-mode
;;auto-complete
(require 'auto-complete-config nil t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'verilog-mode)

;;http://d.hatena.ne.jp/rubikitch/20100423/bytecomp
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; ruby-mode
;;(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(require 'ruby-mode nil t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; rubydb3x
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; rspec-mode
(require 'rspec-mode nil t)
(add-to-list 'rspec-mode 'ruby-mode)
;(setq rspec-use-rake-flag t)

;; ruby-electric 括弧の自動挿入
(require 'ruby-electric nil t)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block nil t)
;;(ruby-block-mode t)

;; rvm.el
;; http://github.com/senny/rvm.el.git
(require 'rvm)


;; autotest.el
(require 'autotest)
(define-key ruby-mode-map "\C-c\C-a" 'autotest-switch)
(define-key shell-mode-map "\C-c\C-a" 'autotest-switch)

;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;; rsense
(setq rsense-home "/home/koga/opt/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc/"))
(require 'rsense)
(add-hook 'ruby-mode-hook
		  (lambda ()
			(local-set-key (kbd "C-c .") 'ac-complete-rsense)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))
(setq rsense-rurema-home "~/src/rurema")

(require 'anything-rurima)
(setq anything-rurima-index-file "~/src/rurema/rubydoc/rurima.e")

;;recent-ext
(require 'recentf-ext)

