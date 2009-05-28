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

;;
;; navi2ch
;;
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;; 行末にあるスペースを強調表示する
(when (boundp 'show-trailing-whitespace) (setq-default show-trailing-whitespace t))
(set-face-background 'trailing-whitespace "plum")
(set-face-underline 'trailing-whitespace t)

;; ツールバーを消す
(tool-bar-mode nil)
;; メニューバーを消す
(menu-bar-mode nil)


;;
;; git-emacs
;;
(add-to-list 'load-path "/home/masahiro/.emacs.d/site-lisp/")
(require 'git-emacs nil t)

;;
;; wl
;;
(if (require 'wanderlust-startup nil t)
    (autoload 'wl "wl" "Wanderlust" t)
    (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
    (autoload 'wo-draft "wl-draft" "Write draft with Wanderlust." t))

;;
;;anthy
;;
(set-language-environment "Japanese")
; set load-path for anthy.el
(push "/usr/share/emacs/site-lisp/anthy/" load-path)
; load anth.el
(load-library "anthy")
; set default for japanese-anthy
(setq default-input-method "japanese-anthy")

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
(require 'text-translator)

(global-set-key "\C-xt" 'text-translator)
(global-set-key "\C-xT" 'test-translator-translate-last-string)

;; translate by using eijiro
(global-set-key "\C-cw" 'sdic-describe-word-at-point)
(global-set-key "\C-cW" 'sdic-describe-word)
