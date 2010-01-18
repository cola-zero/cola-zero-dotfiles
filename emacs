;;;
;;; .emacs
;;;


(add-to-list 'load-path "/home/masahiro/.emacs.d/auto-install/")
(add-to-list 'load-path "/home/masahiro/.emacs.d/site-lisp/")
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

;;ステータスバーの設定
(display-time-mode 1)
(line-number-mode 1)
(column-number-mode 1)

;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 75))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 75)

;; color-theme の設定
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-arjen))

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
			       '("\\.[ch]" . c-mode)
			       '(".emacs" . emacs-lisp-mode)
			       '("\\.v" . verilog-mode)
				   '("\\.[hg]s$"  . haskell-mode)
				   '("\\.hi$"     . haskell-mode)
				   '("\\.l[hg]s$" . literate-haskell-mode)
			       auto-mode-alist)))

;haskell-mode
(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)




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
(menu-bar-mode -1)


;;
;; git-emacs
;;
(add-to-list 'load-path "/home/masahiro/.emacs.d/site-lisp/")
(require 'git-emacs nil t)

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
; set load-path for anthy.el
;(push "/usr/share/emacs/site-lisp/anthy/" load-path)
; load anth.el
;(load-library "anthy")
; set default for japanese-anthy
;(setq default-input-method "japanese-anthy")

;get hostname
(setq hostname (system-name))
(if (null hostname)
    (setq hostname "no_host"))
; 小文字に
(setq hostname (downcase hostname))
; ピリオド以下削除(ピリオドがなければ変更なし)
(setq hostname (car (split-string hostname "\\.")))

;japanese
(when (or (string-match hostname "macbook")
		  (string-match hostname "debian" ))
  (set-keyboard-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8))

;; enable color in console
(global-font-lock-mode t)


;;
;; TRAMP
;;
;; リモートのファイルを編集する
(require 'tramp)

;;
;; multi-tty emacs
;;
(server-start)


;;
;; cscope
;;
(require 'xcscope)

;; C-H を一文字前を削除に変更
;(define-key global-map "^H" 'backward-delete-char)
(define-key global-map "" 'backward-delete-char)

;; text-translator
;; http://d.hatena.ne.jp/khiker/20070503/emacs_text_translator
(require 'text-translator nil t)

(global-set-key "\C-xt" 'text-translator)
(global-set-key "\C-xT" 'test-translator-translate-last-string)

;; translate by using eijiro
(global-set-key "\C-cw" 'sdic-describe-word-at-point)
(global-set-key "\C-cW" 'sdic-describe-word)

;;skk
(require 'skk-auto)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")

;elscreen
(require 'elscreen nil t)
(require 'elscreen-color-theme nil t)
(require 'elscreen-dired nil t)
(require 'elscreen-server nil t)

;howm
(setq howm-menu-lang 'ja)
(require 'howm-mode)

;anything
(require 'anything-config)
(require 'anything-gtags)
(setq anything-sources
      (list anything-c-source-gtags-select
       anything-c-source-buffers
	   anything-c-source-buffer-not-found
       anything-c-source-files-in-current-dir
       anything-c-source-recentf
       anything-c-source-file-name-history
       anything-c-source-locate
	   anything-c-source-info-pages
	   anything-c-source-info-elisp
	   anything-c-source-man-pages
	   anything-c-source-emacs-commands
	   anything-c-source-find-files
	   anything-c-source-file-cache
	   anything-c-source-kill-ring
	   anything-c-source-org-headline
	   anything-c-source-elscreen))
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(define-key global-map (kbd "C-;") 'anything)
(setq anything-gtags-hijack-gtags-select-mode nil) ;error回避


(require 'auto-install)

;gtags
(require 'gtags)
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

;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;debug
;(setq debug-on-error t)

;org-mode
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list `auto-mode-alist '("\\.org$" . org-mode))
(org-remember-insinuate)
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-remember-templates
	  '(("Todo" ?t "** TODO %?\n %i\n %a\n %t" nil "Inbox")
		("Bug" ?b "** TODO %? :bug:\n %i\n %a\n %t" nil "Inbox")
		("Idea" ?i "** %?\n %i\n %a\n %t" nil "New Ideas")
		("Note" ?n "** NOTE %?\n %i\n %a\n %t" nil "Note")
		))
(global-set-key "\C-x\C-x" 'org-remember)
(global-set-key "\C-x\C-r" 'org-remember-code-reading)
(global-set-key "\C-ca" 'org-agenda)

(defvar org-code-reading-software-name nil)
;; ~/memo/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: "
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"
		  "[" hostname "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
             ,org-code-reading-file "Memo"))))
    (org-remember)))

(setq org-agenda-files (list "~/memo/agenda.org"
							 "~/memo/code-reading.org"))

;diary
 (setq diary-file "~/memo/diary.gpg")


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
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;twittering-mode
(require 'twittering-mode nil t)
(setq twittering-username "cola_zero")
