;; packages.el

(load "config/my-package-installer")

(load "config/my-org-mode")

;; color-moccur.el
;; http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
(my-package-install 'emacswiki "color-moccur.el" 'color-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

;; title-time.el
;; http://valvallow.blogspot.com/2011/01/emacs.html
(my-package-install 'emacswiki "title-time.el" 'title-time)
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

;; e2wm
(my-package-install 'github "kiwanami/emacs-window-layout" 'window-layout)
(my-package-install 'github "kiwanami/emacs-window-manager" 'e2wm-config)
(global-set-key (kbd "M-+") 'e2wm:start-management)

;; multi-term
;; http://sakito.jp/emacs/emacsshell.html#emacs-shell
;; curl -O http://www.emacswiki.org/emacs/download/multi-term.el
(my-package-install 'emacswiki "multi-term.el" 'multi-term)
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
(setq milti-term-program shell-file-name)

;; calfw.el
;; http://d.hatena.ne.jp/kiwanami/20110107/1294404952
;;(my-package-install 'github "kiwanami/emacs-calfw" 'calfw)

;; popwin.el
;; https://github.com/m2ym/popwin-el
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(my-package-install 'github "m2ym/popwin-el" 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(add-to-list 'popwin:special-display-config '(" *auto-async-byte-compile*" :height 5 :noselect t))
(add-to-list 'popwin:special-display-config '("*YaTeX-typesetting*"))
(add-to-list 'popwin:special-display-config '("*anything moccur*" :position top))

;; grep-a-lot
;;http://d.hatena.ne.jp/kitokitoki/20110213/p1
(my-package-install 'emacswiki "grep-a-lot.el" 'grep-a-lot)
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
(my-package-install 'yasnippet "yasnippet" 'yasnippet)
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

;; eldoc-extension.el
;; http://d.hatena.ne.jp/rubikitch/20090207/1233936430
(require 'eldoc)
(my-package-install 'emacswiki "eldoc-extension.el" 'eldoc-extension)
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;c-eldoc.el
(my-package-install 'emacswiki "c-eldoc.el" 'c-eldoc)
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
(my-package-install 'github "m2ym/auto-complete" 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/packages/auto-complete/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'verilog-mode)

;; migemo
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(load "migemo.el")
(if (not (eq system-type 'darwin))
    (setq migemo-command "/usr/bin/ruby"))
(migemo-init)
(require 'anything-migemo nil t)

;; rsense
(setq rsense-home (expand-file-name "~/opt/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense nil t)

;; hiki-mode
(setq hiki-site-list
      '(("whale" "http://whale/hiki/hiki.cgi")
        ("ngeda" "http://wiki.arch.cs.kumamoto-u.ac.jp/ngeda/hiki.cgi")))
(setq hiki-site-info
      '("whale" "http://whale/hiki/hiki.cgi"))
(setq hiki-browser-function 'browser-url)
(autoload 'hiki-edit "hiki-mode" nil t)
(autoload 'hiki-edit-url "hiki-mode" nil t)
(autoload 'hiki-index "hiki-mode" nil t)
(require 'hiki-mode)

;; https://github.com/philjackson/magit.git
(my-package-install 'github "philjackson/magit" 'magit)

;; git-status.el
;; http://d.hatena.ne.jp/kitokitoki/20100824/p1
(require 'git-status nil t)

;; twittering-mode
(my-package-install 'github "hayamiz/twittering-mode" 'twittering-mode)
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

;; http://launchpad.net/xml-rpc-el
;; http://launchpadlibrarian.net/40270196/xml-rpc.el
(require 'xml-rpc nil t)

;; org2blog
;; http://www.rlazo.org/2010/10/28/org-mode-wordpress-org2blog-awesomeness/
;; http://github.com/punchagan/org2blog
(my-package-install 'github "punchagan/org2blog" 'org2blog)
(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "http://cola0.wordpress.com/xmlrpc.php"
         :username "colazero1986"
         :default-title "Hello World"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil
         :keep-new-lines t)
        ("whale"
         :url "http://whale.arch.cs.kumamoto-u.ac.jp/blog/xmlrpc.php"
         :username "koga"
         :default-title "今日の日誌"
         :default-categories ("日誌")
         :tags-as-categories nil
         :keep-new-lines t)))
(defun my-org2blog/wp-post-and-publish-subtree ()
  (interactive)
  (org2blog/wp-post-subtree t))
(define-key global-map "\C-cd" 'org2blog/wp-post-subtree)


;;CEDIT
;; (load-file (concat package-base-dir "/cedet-1.0/common/cedet.el"))
;; (global-ede-mode 1)                      ; Enable the Project management system
;; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;; (global-srecode-minor-mode 1)            ; Enable template insertion menu

;; ecb
;; (require 'ecb)

;; elscreen
(require 'elscreen nil t)
(require 'elscreen-dired nil t)
(require 'elscreen-server nil t)
(require 'elscreen-speedbar nil t)
(require 'elscreen-w3m nil t)
(require 'elscreen-color-theme nil t)

;; anything
(my-package-install 'repo.or.cz '((files . ("anything-config"))
                               (additional-paths . ("extensions")))
                 'anything-startup)
;; (require 'anything-startup)
(define-key global-map (kbd "C-x b") 'anything-filelist+)

;; http://d.hatena.ne.jp/rubikitch/20100423/bytecomp
(my-package-install 'emacswiki "auto-async-byte-compile.el" 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; popwin.el
;; https://github.com/m2ym/popwin-el
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(my-package-install 'github "m2ym/popwin-el" 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(add-to-list 'popwin:special-display-config '(" *auto-async-byte-compile*" :height 5 :noselect t))

