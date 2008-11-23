;;;
;;; .emacs
;;;


;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 75))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 75)

(when (require 'color-theme nil t)
  (color-theme-initialize)
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
(add-to-list 'load-path "/Users/kogamasahiro/.emacs.d/elisp/git-emacs")
(require 'git-emacs nil t)