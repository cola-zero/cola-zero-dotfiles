;; ~/.emacs.d/cola-zero/builtin.el

(setq inhibit-startup-screen t)

(server-start)

;; use utf-8 coding system
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(menu-bar-mode -1)
(tool-bar-mode -1)

(blink-cursor-mode t)

(show-paren-mode 1)

(setq-default show-trailing-whitespace nil)

;; display images
(auto-image-file-mode t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Emacs gurus don't need no stinking scroll bars
(when (fboundp 'toggle-scroll-bar)
  (toggle-scroll-bar -1))

;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)

;; Line-wrapping
(set-default 'fill-column 80)

;; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; `brew install aspell --lang=en` (instead of ispell)
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; history
(setq history-length 10000)
(savehist-mode t)
(require 'recentf)
(setq recentf-max-saved-items 10000)

;;enable gz file editing
(auto-compression-mode t)

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; zap-up-to-char, forward-to-word, backward-to-word, etc
(require 'misc)

;; use spaces instead of tabs
(setq-default tab-width 4 indent-tabs-mode nil)

(setenv "DYLD_FALLBACK_LIBRARY_PATH" "/usr/local/lib")

;; delete trailing whitespace when save buffere
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'config-builtin)
