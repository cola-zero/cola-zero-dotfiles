;; packages

(require 'cl)

(defvar package-base-dir "~/.emacs.d/packages")

(defun package-path-basename (path)
  (file-name-sans-extension (file-name-nondirectory path)))

(defun package-directory (files)
  (concat package-base-dir "/"
          (package-path-basename (car files))))

(defun package-run-shell-command (command)
  (message (format "running...: %s" command))
  (shell-command command))

(defun package-install-from-coderepos (files)
  (shell-command
   (format (concat "svn co http://svn.coderepos.org/share/lang/elisp/%s/trunk %s")
           (car files)
           (package-directory files))))

(defun package-install-from-yasnippet (files)
  (shell-command
   (format (concat "svn checkout http://yasnippet.googlecode.com/svn/trunk/ %s")
           (package-directory files))))

(defun package-install-from-orgmode (files)
  (shell-command
   (format (concat "git clone git://orgmode.org/org-mode.git %s")
           (package-directory files))))

(defun package-install-from-emacswiki (files)
  (shell-command
   (format "mkdir -p %s" (package-directory files)))
  (package-run-shell-command
   (format "wget --directory-prefix %s %s"
           (package-directory files)
           (mapconcat (lambda (name)
                        (concat "http://www.emacswiki.org/emacs/download/"
                                name))
                      files
                      " "))))

(defun package-install-from-gist (gistid)
  (package-run-shell-command
   (format (concat "git clone git://gist.github.com/%s.git %s")
           (car files)
           (package-directory files))))

(defun package-install-from-github (files)
  (package-run-shell-command
   (format (concat "git clone https://github.com/%s.git %s")
           (car files)
           (package-directory files))))

(defun package-install-from-repo.or.cz (files)
  (package-run-shell-command
   (format (concat "git clone git://repo.or.cz/%s.git %s")
           (car files)
           (package-directory files))))

(defun package-alist-value (alist key default-value)
  (if (listp alist)
      (let ((alist-item (assoc key alist)))
        (if alist-item
            (cdr alist-item)
          default-value))
    default-value))

(defun package-install (type package-spec require-name &optional force)
  (let ((files (package-alist-value package-spec 'files
                                    (if (listp package-spec)
                                        package-spec
                                      (list package-spec))))
        (base-path (package-alist-value package-spec 'base-path "."))
        (additional-paths (package-alist-value package-spec 'additional-paths
                                               nil))
        (install-proc (case type
                        (yasnippet
                         'package-install-from-yasnippet)
                        (orgmode
                         'package-install-from-orgmode)
                        (coderepos
                         'package-install-from-coderepos)
                        (emacswiki
                         'package-install-from-emacswiki)
                        (github
                         'package-install-from-github)
                        (gist
                         'package-install-from-gist)
                        (repo.or.cz
                         'package-install-from-repo.or.cz)
                        (t
                         (error "unknown package type: <%s>(%s)"
                                type package)))))
    (add-to-list 'load-path
                 (format "%s/%s"
                         (package-directory files)
                         base-path))
    (dolist (additional-path additional-paths)
      (add-to-list 'load-path (format "%s/%s"
                                      (package-directory files)
                                      additional-path)))
    (condition-case err
        (require require-name)
      (error
       (message (format "installing %s..." files))
       (funcall install-proc files)))
    (require require-name)))


;; auto-install
(package-install 'emacswiki "auto-install.el" 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(add-to-list 'load-path "~/.emacs.d/auto-install")



;; emacs-deferred
(package-install 'github "kiwanami/emacs-deferred" 'deferred)

;; color-moccur.el
;; http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
(package-install 'emacswiki "color-moccur.el" 'color-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

;; Anything
(load "config/my-anything")

;; title-time.el
;; http://valvallow.blogspot.com/2011/01/emacs.html
(package-install 'emacswiki "title-time.el" 'title-time)
(defadvice title-time-set (around title-time-set-around)
  (setq frame-title-format
        (concat "%b" " - " display-time-string)))
(ad-activate 'title-time-set)
(setq display-time-interval 30)
(setq display-time-string-forms
      '((format " [ %s/%02d/%02d (%s) - %s:%s ] "
                year (string-to-number month)(string-to-number day)
                dayname 24-hours minutes)))
(display-time)

;; color-theme
;; not auto-installed.
;; (when (require 'color-theme nil t)
;;   (color-theme-initialize)
;;   ;; http://elpa.gnu.org/themes/3LokbOLb
;;   (load "~/.emacs.d/site-lisp/misterioso-theme"))

;; mozc
(if (eq window-system 'x)
    (progn
      (require 'mozc)  ; or (load-file "path-to-mozc.el")
      (set-language-environment "Japanese")
      (setq default-input-method "japanese-mozc")))

;; Elscreen
;; not auto-installed.
(require 'elscreen nil t)
(require 'elscreen-color-theme nil t)
(require 'elscreen-dired nil t)
(require 'elscreen-server nil t)
(require 'elscreen-howm nil t)
(setq elscreen-display-tab t)
(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
	   (screen-to-name-alist (elscreen-get-screen-to-name-alist))
	   (title (mapconcat
		   (lambda (screen)
		     (format "%d%s %s"
			     screen (elscreen-status-label screen)
			     (get-alist screen screen-to-name-alist)))
		   screen-list " ")))
      (if (fboundp 'set-frame-name)
	  (set-frame-name title)
	(setq frame-title-format title)))))

(eval-after-load "elscreen"
    '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))

;; org-mode
(load "config/my-org-mode")

;; w3m
;; not auto-installed
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'load-path (expand-file-name "~/opt/emacs-w3m/share/emacs/site-lisp/w3m/"))
(require 'w3m-load nil t)


;; e2wm
(package-install 'github "kiwanami/emacs-window-layout" 'window-layout)
(package-install 'github "kiwanami/emacs-window-manager" 'e2wm-config)
(global-set-key (kbd "M-+") 'e2wm:start-management)

;; multi-term
;; http://sakito.jp/emacs/emacsshell.html#emacs-shell
;; curl -O http://www.emacswiki.org/emacs/download/multi-term.el
(package-install 'emacswiki "multi-term.el" 'multi-term)
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
(setq milti-term-program shell-file-name)

;; japanese-holiday.el
;; not auto-installed
(add-hook 'calendar-load-hook
          (lambda ()
            (require 'japanese-holidays nil t)
            (setq calendar-holidays
                  (append japanese-holidays holiday-local-holidays other-holidays))))

;; calfw.el
;; http://d.hatena.ne.jp/kiwanami/20110107/1294404952
(package-install 'github "kiwanami/emacs-calfw" 'calfw)


;; popwin.el
;; https://github.com/m2ym/popwin-el
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(package-install 'github "m2ym/popwin-el" 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(add-to-list 'popwin:special-display-config '(" *auto-async-byte-compile*" :height 5 :noselect t))
(add-to-list 'popwin:special-display-config '("*YaTeX-typesetting*"))
(add-to-list 'popwin:special-display-config '("*anything moccur*" :position top))

;; grep-a-lot
;;http://d.hatena.ne.jp/kitokitoki/20110213/p1
(package-install 'emacswiki "grep-a-lot.el" 'grep-a-lot)
(grep-a-lot-setup-keys)
(defvar my-grep-a-lot-search-word nil)
(defun grep-a-lot-buffer-name (position)
  "Return name of grep-a-lot buffer at POSITION."
  (concat "*grep*<" my-grep-a-lot-search-word ">"))
(defadvice rgrep (before my-rgrep (regexp &optional files dir) activate)
  (setq my-grep-a-lot-search-word regexp))
(defadvice lgrep (before my-lgrep (regexp &optional files dir) activate)
  (setq my-grep-a-lot-search-word regexp))

;; yasnippet
(package-install 'yasnippet "yasnippet" 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/packages/yasnippet/snippets")

;; yasnippet and ruby-electric
;; http://code.google.com/p/yasnippet/issues/detail?id=71
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))
(yas/advise-indent-function 'ruby-indent-line)

;; cscope
;; not auto-installed
(require 'xcscope nil t)

;; gtags
;; not auto-installed
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


;; eldoc-extension.el
;; http://d.hatena.ne.jp/rubikitch/20090207/1233936430
(require 'eldoc)
(package-install 'emacswiki "eldoc-extension.el" 'eldoc-extension)
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;c-eldoc.el
(package-install 'emacswiki "c-eldoc.el" 'c-eldoc)
;; (load "c-eldoc")
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
      (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t))
    (progn
      (add-to-list 'load-path "/usr/local/Cellar/emacs/23.2/share/emacs/site-lisp/yatex/")
      (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
      (setq tex-command "platex")
      (setq dvi2-command "open")
      ;; (add-to-list 'YaTeX-dvi2-command-ext-alist
      ;;              ("open" . ".dvi"))
      (add-to-list 'auto-mode-alist '("\\.tex\\'" . yatex-mode))))

;; auto-complete-mode
(package-install 'github "m2ym/auto-complete" 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/packages/auto-complete/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'verilog-mode)

;; http://d.hatena.ne.jp/rubikitch/20100423/bytecomp
(package-install 'emacswiki "auto-async-byte-compile.el" 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; migemo
;; not auto-installed
(when (require 'anything-migemo nil t)
  (progn
    (load "migemo.el")
    (setq migemo-command "/usr/bin/ruby")
    (if (eq system-type 'darwin)
        (progn
          (setq migemo-command "/usr/local/bin/cmigemo")
          (setq migemo-options '("-q" "--emacs" "-i" "\a"))
          (setq migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict")
          (setq migemo-user-dictionary nil)
          (setq migemo-regex-dictionary nil)
          ))
    (migemo-init)))

;; slime
(load "config/my-slime")

;; navi2ch
(add-to-list 'load-path (concat package-base-dir "/navi2ch"))
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;; id-manager.el
(package-install 'github "kiwanami/emacs-id-manager" 'id-manager)

;; rvm.el
(package-install 'github "senny/rvm.el" 'rvm)


;; evernote-mode
;; (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))
;; (add-to-list 'load-path (concat package-base-dir "/evernote-mode"))
;; (require 'evernote-mode)
;; (global-set-key "\C-cec" 'evernote-create-node)
;; (global-set-key "\C-ceo" 'evernote-open-note)
;; (global-set-key "\C-ces" 'evernote-search-notes)
;; (global-set-key "\C-ceS" 'evernote-do-saved-search)
;; (global-set-key "\C-cew" 'evernote-write-note)



;; rsense
(setq rsense-home (expand-file-name "~/opt/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

;; hiki-mode
(setq hiki-site-list
      '(("whale" "http://whale/hiki/hiki.cgi")))
(setq hiki-browser-function 'browser-url)
(autoload 'hiki-edit "hiki-mode" nil t)
(autoload 'hiki-edit-url "hiki-mode" nil t)

;; https://github.com/philjackson/magit.git
(package-install 'github "philjackson/magit" 'magit)

;; gccsense
(require 'gccsense nil t)

;; twittering-mode
(package-install 'github "hayamiz/twittering-mode" 'twittering-mode)
(setq twittering-use-master-password t)
;;http://mitukiii.jp/2010/11/01/twittering-mode/
(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        "cola_zero/kumamoto"
        ":favorites"
        ":direct_messages"))
;; キーを設定
(add-hook 'twittering-mode-hook
          '(lambda ()
             (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
             (define-key twittering-mode-map (kbd "R") 'twittering-reply-to-user)
             (define-key twittering-mode-map (kbd "Q") 'twittering-organic-retweet)
             (define-key twittering-mode-map (kbd "T") 'twittering-native-retweet)
             (define-key twittering-mode-map (kbd "M") 'twittering-direct-message)
             (define-key twittering-mode-map (kbd "N") 'twittering-update-status-interactive)
             (define-key twittering-mode-map (kbd "C-c C-f") 'twittering-home-timeline)))




;; scala-mode
(add-to-list 'load-path (expand-file-name "~/opt/scala-2.8.1.final/misc/scala-tool-support/emacs/"))
(require 'scala-mode-auto)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))

;; ENSLIME
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/ensime_2.8.1-0.5.0/elisp"))
(add-to-list 'exec-path (expand-file-name "~/opt/bin"))
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
