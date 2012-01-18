(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(defvar my-emacs-config-dir (expand-file-name "~/.emacs.d/cola-zero"))

(setq custom-file "~/.emacs.d/cola-zero/custom.el")
(load custom-file 'noerror)

;; https://github.com/okkez/dotfiles/blob/master/emacs-config/start.el
(defun my-emacs-load-config (name)
  "Load NAME as a configure file in `my-emacs-config-dir'.
Assume that the filename should be config-NAME.el."
  (load (concat my-emacs-config-dir "/config-" name ".el")))

(defvar my-emacs-pre-config '("elpa" "el-get"))

(defvar my-emacs-misc-config
  '("font"
    "builtin"
    "keybind"
    "hi-line-mode"
    "mode-line"
    "tramp"
    "gdb"
    "dired"
    "iswitchb"
    "apel"
    "auto-async-byte-compile"
    "minibuf-isearch"
    "session"
    ;; "color-theme"
    "popwin"
    ;; "elscreen"
    ;; "elscreen-color-theme"
    ;; "elscreen-dired"
    ;; "elscreen-server"
    "scala-mode-auto"
    "haskell-mode"
    "ghc-mode"
    "dsvn"
    "magit"
    "gist"
    "e2wm"
    "c-eldoc"
    "auto-complete"
    "migemo"
    "ruby-mode"
    "ruby-block"
    "ruby-electric"
   ;; "haml-mode"
   ;; "sass-mode"
    "yari"
    ;; "rvm"
    "rsense"
    "rinari"
    "ri-emacs"
    "yaml-mode"
    ;; "slime" ;broken
    ;; "ac-slime"
    "cl-indent-patches"
    "clojure-mode"
    "deferred"
    ;; "dict-osx" ;; broken
    "po-mode"
    "ecb"
    "yasnippet"
    "markdown-mode"
    "org-mode"
    "org-ja"
    "org-jekyll"
    "org-mac-protocol"
    ;; "deft"
    ;; "bbdb"
    "calfw"
    "id-manager"
    ;; "flim"
    ;; "semi"
    ;; "emacs-w3m"
    ;; "wanderlust"
    "evernote-mode"
    ))

(if (eq system-type 'darwin)
    (add-to-list 'my-emacs-misc-config "darwin"))

(defvar my-emacs-post-config nil)
(defvar my-emacs-config
  (append nil my-emacs-pre-config my-emacs-misc-config my-emacs-post-config))

(mapcar 'my-emacs-load-config my-emacs-config)
