;; ~/.emacs.d/init.el

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

;; get hostname
(setq hostname (system-name))
(if (null hostname)
    (setq hostname "no_host"))
;;  小文字に
(setq hostname (downcase hostname))
;;  ピリオド以下削除(ピリオドがなければ変更なし)
(setq hostname (car (split-string hostname "\\.")))

;; japanese
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; keybind
;; C-F C-B C-P C-Nでウィンドウの移動
;; http://d.hatena.ne.jp/authorNari/20091225/1261667956
(setq windmove-wrap-around t)
(define-key global-map [(C shift n)] 'windmove-down)
(define-key global-map [(C shift p)] 'windmove-up)
(define-key global-map [(C shift b)] 'windmove-left)
(define-key global-map [(C shift f)] 'windmove-right)


;; 画像を表示
(auto-image-file-mode t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)

;; print all eval expression
(setq eval-expression-print-length nil)

(show-paren-mode 1)
(setq show-paren-style 'mixed)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; enable color in console
(global-font-lock-mode t)


(global-hl-line-mode t)
(column-number-mode t)
(line-number-mode t)
(require 'saveplace)
(setq-default save-place t)

(setq require-final-newline t)
(setq next-line-add-newlines nil)

(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; tab
(setq tab-width 4)
(setq-default indent-tabs-mode nil)

;; completion
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; partial completion
(partial-completion-mode t)
(icomplete-mode 1)

;; history
(setq history-length 10000)
;; save minibuffer history
(savehist-mode t)
(setq recentf-max-saved-items 10000)

;; enable gz file editing
(auto-compression-mode t)

;; diff
(setq ediff-window-setup-function 'ediff-setup-window-plain)
(setq diff-switches '("-u" "-p" "-N"))

;; dired
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; buffer-name
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

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

;; emacs-daemon
(server-start)


(load "config/builtins")

(load "config/packages")

(if (eq system-type 'darwin)
    (load "config/darwin.el"))
