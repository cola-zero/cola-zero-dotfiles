;;;
;;; .emacs
;;;


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
(require 'elscreen)
(require 'elscreen-color-theme)
(require 'elscreen-dired)
(require 'elscreen-server)

;howm
(setq howm-menu-lang 'ja)
(require 'howm-mode)

;anything
(require 'anything-config)
(require 'anything-gtags)
(setq anything-sources
      (list anything-c-source-gtags-select
       anything-c-source-buffers
       anything-c-source-files-in-current-dir
       anything-c-source-recentf
       anything-c-source-file-name-history
       anything-c-source-locate))
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
(global-set-key "\C-ca" 'org-remember-code-reading)

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
          "[" (org-code-reading-read-software-name) "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
             ,org-code-reading-file "Memo"))))
    (org-remember)))
(setq org-agenda-files (list "~/memo/agenda.org"
							 "~/memo/code-reading.org"))