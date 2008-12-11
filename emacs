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

;;
;; git-emacs
;;
(add-to-list 'load-path "/$HOME/.emacs.d/elisp/git-emacs")
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
