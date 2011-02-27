;;;
;;; .emacs.d/init.el
;;;
(setq inhibit-startup-message -1)

;; load-path
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/apel")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emu")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/migemo")

;; do not make backup files
(setq make-backup-files nil)

;; http://d.hatena.ne.jp/tototoshi/20101202/1291289625
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; auto-install
(require 'auto-install nil t)
(auto-install-update-emacswiki-package-name t)

;; anything
(require 'anything-startup nil t)
(define-key global-map (kbd "C-x b") 'anything-filelist+)
(define-key global-map (kbd "C-x C-f") 'anything-filelist+)
(setq anything-c-filelist-file-name "/tmp/mnt/all.filelist")
(setq anything-grep-candidates-fast-directory-regexp "^/tmp\/mnt")
(add-to-list 'anything-c-source-buffers '(migemo))
(when (eq system-type 'darwin)
  (progn
    (add-to-list 'load-path (expand-file-name "~/work/emacs/anything-mac-itunes"))
    (require 'anything-mac-itunes)
    (global-set-key (kbd "C-c i m") 'anything-mac-itunes)
    (global-set-key (kbd "C-c i b") 'anything-mac-itunes-back-track)
    (global-set-key (kbd "C-c i n") 'anything-mac-itunes-next-track)
    (global-set-key (kbd "C-c i p") 'anything-mac-itunes-playpause-track)
    (global-set-key (kbd "C-c i C") 'anything-mac-itunes-show-current-track-info)))
;; (setq anything-use-migemo t)

;; anything-hatena-bookmark.el
(add-to-list 'load-path (expand-file-name "~/work/emacs/anything-hatena-bookmark"))
(require 'anything-hatena-bookmark)
(global-set-key (kbd "C-c C-b") 'anything-hatena-bookmark)
(setq anything-hatena-bookmark-samewindow t)

;; descbinds-anything.el
(require 'descbinds-anything)
(descbinds-anything-install)

;(require 'resetf-ext)
;; (require 'anything-config nil t)
;; (define-key global-map (kbd "C-x b") 'anything-for-buffers)
;; (define-key global-map (kbd "C-x C-z") 'anything-execute-persistent-action)

;; emacs-deferred
(add-to-list 'load-path (expand-file-name "~/work/emacs/emacs-deferred/"))

;; emacs-inertial-scroll
;; (add-to-list 'load-path (expand-file-name "~/work/emacs/emacs-inertial-scroll/"))
;; (require 'inertial-scroll)
;; (inertias-global-minor-mode 1)
;; (setq inertias-initial-velocity 50)
;; (setq inertias-friction 120)
;; (setq inertias-update-time 50)
;; (setq inertias-rest-coef 0.1)
;; (setq inertias-global-minor-mode-map
;;       (inertias-define-keymap
;;        '(
;;          ;; Mouse wheel scrolling
;;          ("<wheel-up>"   . inertias-down-wheel)
;;          ("<wheel-down>" . inertias-up-wheel)
;;          ("<mouse-4>"    . inertias-down-wheel)
;;          ("<mouse-5>"    . inertias-up-wheel)
;;          ;; Scroll keys
;;          ("<next>"  . inertias-up)
;;          ("<prior>" . inertias-down)
;;          ("C-v"     . inertias-up)
;;          ("M-v"     . inertias-down)
;;          ) inertias-prefix-key))
;; (inertias-global-minor-mode 1)


;; ;; anything book
;; ;; http://d.hatena.ne.jp/kiwanami/20101117/1290015869
;; (add-to-list 'load-path (expand-file-name "~/work/emacs/emacs-anything-books"))
;; (require 'anything-books)
;; (setq abks:books-dir (expand-file-name "~/Library/Application Support/Mendeley Desktop/Downloaded"))
;; (setq abks:open-command "open -a Preview")


;;http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
;;; color-moccur.elの設定
(require 'color-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

;;; anything-c-moccurの設定
(add-to-list 'load-path (expand-file-name "~/work/emacs/anything-c-moccur/"))
(require 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))

;; anything-show-kill-ring
(global-set-key (kbd "C-M-y") 'anything-show-kill-ring)

;; anything-project.el
;; https://github.com/imakado/anything-project.git
(add-to-list 'load-path (expand-file-name "~/work/emacs/anything-project"))
(require 'anything-project)
(global-set-key (kbd "C-c C-f") 'anything-project)

;; get hostname
(setq hostname (system-name))
(if (null hostname)
    (setq hostname "no_host"))
;;  小文字に
(setq hostname (downcase hostname))
;;  ピリオド以下削除(ピリオドがなければ変更なし)
(setq hostname (car (split-string hostname "\\.")))

;; japanese
(when
    (or
     (string-match hostname "macbook-air")
     (string-match hostname "macbook")
     (string-match hostname "debian" )
     (string-match hostname "koga_dr" )
     (string-match hostname "whale"))
  (prefer-coding-system 'utf-8))
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; macにおけるIMEの設定
;; http://tezfm.blogspot.com/2009/11/cocoa-emacs.html
(if (eq window-system 'ns)
    (progn
      (set-language-environment "Japanese")
      (setq default-input-method "MacOSX")
      ;; minibufferは英数モードで始める
      (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
      (load "cl")
      (add-hook
       'post-command-hook
       (lexical-let ((previous-buffer nil))
         #'(lambda ()
             (unless (eq (current-buffer) previous-buffer)
               ;; (message "Change IM %S -> %S" previous-buffer (current-buffer))
               (if (bufferp previous-buffer) (mac-handle-input-method-change))
               (setq previous-buffer (current-buffer))))))))

;; enable color in console
(global-font-lock-mode t)


;; my-setup-ascii.el
(autoload 'my-sample-ascii "my-sample-ascii" "" t)
(autoload 'my-sample-face-size "my-sample-ascii" "" t)




;;ステータスバーの設定
(display-time-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode -1)
(if (eq window-system 'ns)
    (menu-bar-mode 1)
    (menu-bar-mode -1))

;; title-time.el
;; http://valvallow.blogspot.com/2011/01/emacs.html
(defadvice title-time-set (around title-time-set-around)
  (setq frame-title-format
        (concat "%b" " - " display-time-string)))
(ad-activate 'title-time-set)
(setq display-time-interval 30)
(setq display-time-string-forms
      '((format " [ %s/%02d/%02d (%s) - %s:%s ] "
                year (string-to-number month)(string-to-number day)
                dayname 24-hours minutes)))
(require 'title-time)
(display-time)

;; color-theme の設定
(defun my-color-theme ()
  (interactive)
  (color-theme-install
   '(my-color-theme
      ((background-color . "#f0f0f0")
      (background-mode . light)
      (border-color . "#969696")
      (cursor-color . "#7994e6")
      (foreground-color . "#000000")
      (mouse-color . "black"))
     (fringe ((t (:background "#969696"))))
     (mode-line ((t (:foreground "#ffffff" :background "#595959"))))
     (region ((t (:background "#bcb3b3"))))
     (font-lock-builtin-face ((t (:foreground "#f820b4"))))
     (font-lock-comment-face ((t (:foreground "#7d827d"))))
     (font-lock-function-name-face ((t (:foreground "#102cc1"))))
     (font-lock-keyword-face ((t (:foreground "#b415c1"))))
     (font-lock-string-face ((t (:foreground "#c77429"))))
     (font-lock-type-face ((t (:foreground"#199915"))))
     (font-lock-variable-name-face ((t (:foreground "#e6a00f"))))
     (minibuffer-prompt ((t (:foreground "#7299ff" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))
(provide 'my-color-theme)
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (my-color-theme))
  ;; (color-theme-katester))
;  (color-theme-charcoal-black))
;  (color-theme-gray30))

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

;; タブ幅の設定
(setq tab-width 4)
;; indentにtabだけを使う
(setq indent-tabs-mode nil)

;; 行末にあるスペースを強調表示する
(when (boundp 'show-trailing-whitespace) (setq-default show-trailing-whitespace t))
(set-face-background 'trailing-whitespace "plum")
(set-face-underline-p 'trailing-whitespace t)

;; TRAMP
(require 'tramp nil t)
;; http://www.trashpot.org/scratch/2008/05/tramp_zsh.html
(setq tramp-default-method "scpx")
;; https://www.asp-edita.jp/doda/one/doda7807_155.html
(defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  (let ((vc-handled-backends '(SVN Git))) ad-do-it))

;; ;; skk-mode
;; (require 'skk-auto nil t)
;; (if (eq window-system 'w32)
;; 	(setq skk-large-jisyo "~/AppData/Roaming/skkime/SKK-JISYO.L")
;;   (setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L"))

;; ibus.el
;; (require 'ibus)
;; (add-hook 'after-init-hook 'ibus-mode-on)

;; ;; ibus-mozc
;; (ibus-define-common-key ?\C-j t)
;; (setq ibus-prediction-window-position t)

;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-mozc/")
(if (eq window-system 'x)
    (progn
      (require 'mozc)  ; or (load-file "path-to-mozc.el")
      (set-language-environment "Japanese")
      (setq default-input-method "japanese-mozc")))


;; emacs-daemon
(server-start)

;; elscreen
(require 'elscreen nil t)
(require 'elscreen-color-theme nil t)
(require 'elscreen-dired nil t)
(require 'elscreen-server nil t)
(require 'elscreen-howm nil t)
(setq elscreen-display-tab nil)
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


;; Google Chrome Edit with Emacs
;; (require 'edit-server)
;; (edit-server-start)


;; org-mode
(load "~/.emacs.d/my-org-mode.el")

;; howm
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/howm"))
(setq howm-menu-lang 'ja)
(require 'howm)
(define-key global-map (kbd "C-c C-c") 'howm-create)

(eval-after-load "calendar"
  '(progn
     (define-key calendar-mode-map
       "\C-m" 'my-insert-day)
     (defun my-insert-day ()
       (interactive)
       (let ((day nil)
             (calendar-date-display-form
         '("[" year "-" (format "%02d" (string-to-int month))
           "-" (format "%02d" (string-to-int day)) "]")))
         (setq day (calendar-date-string
                    (calendar-cursor-to-date t)))
         (exit-calendar)
         (insert day)))))

;; (setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")

;; anything-howm
;; (add-to-list 'load-path (expand-file-name "~/work/emacs/anything-howm/"))
;; (require 'anything-howm)
;; (setq anything-howm-recent-menu-number-limit 600)
;; ;; howm のデータディレクトリへのパス
;; (setq anything-howm-data-directory "~/Dropbox/memo/howm/")
;; (global-set-key (kbd "M-C-2") 'anything-howm-menu-command)
;; (global-set-key (kbd "M-C-3") 'anything-cached-howm-menu)

;; (defun anything-buffers ()
;;   (interactive)
;;   (anything-other-buffer
;;    '(anything-c-source-buffers+-howm-title
;;      anything-c-source-recentf
;;      )
;;    "*Buffer+File*"))
;; (global-set-key (kbd "M-h") 'anything-buffers)


;; C-F C-B C-P C-Nでウィンドウの移動
;; http://d.hatena.ne.jp/authorNari/20091225/1261667956
(setq windmove-wrap-around t)
(define-key global-map [(C shift n)] 'windmove-down)
(define-key global-map [(C shift p)] 'windmove-up)
(define-key global-map [(C shift b)] 'windmove-left)
(define-key global-map [(C shift f)] 'windmove-right)

;; uniquify
;; http://nlp.kuee.kyoto-u.ac.jp/~shibata/mt/archives/000116.html
(require 'uniquify nil t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; growl
;; http://mitukiii.jp/2010/11/01/twittering-mode/
(setq growl-program "/usr/local/bin/growlnotify")
(defun growl (title message &optional app)
  (start-process "Growl" "*Growl*" growl-program
                 "-t" title
                 "-m" message
                 "-a" app))

;; twittering-mode
(add-to-list 'load-path "~/work/emacs/twittering-mode/")
(require 'twittering-mode nil t)
(setq twittering-use-master-password t)
;;http://mitukiii.jp/2010/11/01/twittering-mode/
(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        "cola_zero/kumamoto"
        ":favorites"
        ":direct_messages"))
;; replyとdmをgrowlで出す
(add-hook 'twittering-new-tweets-hook
          '(lambda ()
             (let ((spec (car twittering-new-tweets-spec))
                   (title-format nil))
               (cond ((eq spec 'replies)
                      (setq title-format "%sから関連ツイート"))
                     ((eq spec 'direct_messages)
                      (setq title-format "%sから新規メッセージ")))
               (unless (eq title-format nil)
                 (dolist (el (reverse twittering-new-tweets-statuses))
                   (growl (format title-format (cdr (assoc 'user-screen-name el)))
                          (format "%s" (cdr (assoc 'text el)))
                          "Emacs")
                   (sleep-for 0 50))))))

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

;; web_browserをchromeに変更
;; http://d.hatena.ne.jp/suji_ski/20100710
;; (setq browse-url-browser-function
;;       '(("."        . browse-url-generic)))
;; (setq browse-url-generic-program "google-chrome")

;; (setq browse-url-browser-function 'w3m-browse-url
;;       browse-url-generic-program "/usr/bin/google-chrome")

;; w3m
;; (add-to-list 'exec-path "/usr/local/bin")
;; (add-to-list 'load-path (expand-file-name "~/opt/emacs-w3m/share/emacs/site-lisp/w3m/"))
;; (require 'w3m-load)


;; 編集行を目立たせる
;; 【Emacs】 カーソル行のハイライト: 日々此精進
;; http://murakan.cocolog-nifty.com/blog/2009/01/emacs-tips-1d45.html
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gridColor"))
    (((class color)
      (background light))
     (:background "gridColor"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

(if (eq window-system 'ns)
	(progn
	  (define-key global-map [?¥] [?\\])
	  (define-key global-map [?\C-¥] [?\C-\\])
	  (define-key global-map [?\M-¥] [?\M-\\])
	  (define-key global-map [?\C-\M-¥] [?\C-\M-\\])))

(if (eq window-system 'ns)
	(progn
	  (define-key global-map [?¥] [?\\])
	  (define-key global-map [?\C-¥] [?\C-\\])
	  (define-key global-map [?\M-¥] [?\M-\\])
	  (define-key global-map [?\C-\M-¥] [?\C-\M-\\])))

;; wandarlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; e2wm
;; 最小の e2wm 設定例
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
(add-to-list 'load-path (expand-file-name "~/work/emacs/emacs-window-layout"))
(add-to-list 'load-path (expand-file-name "~/work/emacs/emacs-window-manager"))
(require 'e2wm-config nil t)
(require 'e2wm nil t)
(global-set-key (kbd "M-+") 'e2wm:start-management)

;; term-mode
;; (add-hook 'term-mode-hook
;; 		  '(lambda ()
;; 			 (define-key term-raw-map "\C-p" 'previous-line)
;; 			 (define-key term-raw-map "\C-n" 'next-line)))
;; (add-to-list 'term-unbind-key-list '"M-x")

;; multi-term
;; http://sakito.jp/emacs/emacsshell.html#emacs-shell
;; curl -O http://www.emacswiki.org/emacs/download/multi-term.el
;; (defun skt:shell ()
;;   (or (executable-find "zsh")
;;       (executable-find "bash")
;;       (executable-find "cmdproxy")
;;       (error "can't find 'shell' command in PATH!!")))
;; (setq shell-file-name (skt:shell))
;; (setenv "SHELL" shell-file-name)
;; (setq explicit-shell-file-name shell-file-name)
;; (require 'multi-term)
;; (setq milti-term-program shell-file-name)

;; indent with space
(setq-default indent-tabs-mode nil)

;; migemo
(require 'anything-migemo)
(load "migemo.el")
(if (eq window-system 'ns)
	(progn
          (setq migemo-command "/usr/bin/ruby")
          (setq migemo-command "/usr/local/bin/cmigemo")
          (setq migemo-options '("-q" "--emacs" "-i" "\a"))
          (setq migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict")
          (setq migemo-user-dictionary nil)
          (setq migemo-regex-dictionary nil)
          ))
(migemo-init)

;; auto-save-buffer-enhanced.el
;;http://0xcc.net/misc/auto-save/
;;http://d.hatena.ne.jp/antipop/20080222/1203688543
(add-to-list 'load-path (expand-file-name "~/work/emacs/auto-save-buffers-enhanced/"))
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-include-only-checkout-path t)
(setq auto-save-buffers-enhanced t)

;; w3m
(setq w3m-use-cookies t)
(setq w3m-default-display-inline-images t)

;; emacs-evernote-mode
(require 'evernote-mode nil t)
(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)

;; pukiwiki-mode
;; (setq pukiwiki-site-list
;;       '(("Meadow" "http://www.bookshelf.jp/pukiwiki/pukiwiki.php" nil euc-jp-dos)
;;         ("dolphin" "http://dolphin.arch.cs.kumamoto-u.ac.jp/wiki/index.php" nil euc-jp-unix)
;;         ))
;; (setq pukiwiki-auto-insert t)
;; (autoload 'pukiwiki-edit "pukiwiki-mode" nil t)
;; (autoload 'pukiwiki-index "pukiwiki-mode" nil t)
;; (autoload 'pukiwiki-edit-url "pukiwiki-mode" nil t)

;; japanese-holiday.el
(add-hook 'calendar-load-hook
          (lambda ()
            (require 'japanese-holidays)
            (setq calendar-holidays
                  (append japanese-holidays holiday-local-holidays other-holidays))))

;; calfw.el
;; http://d.hatena.ne.jp/kiwanami/20110107/1294404952
(add-to-list 'load-path (expand-file-name "~/work/emacs/emacs-calfw"))
(require 'calfw)
;; calfw-howm.el
(defvar my-howm-schedule-page "2011-todo"); 予定を入れるメモのタイトル

(defun my-cfw-open-schedule-buffer ()
  (interactive)
  (let*
      ((date (cfw:cursor-to-nearest-date))
       (howm-items
        (howm-folder-grep
         howm-directory
         (regexp-quote my-howm-schedule-page))))
    (cond
      ((null howm-items); create
       (howm-create-file-with-title my-howm-schedule-page nil nil nil nil))
      (t
       (howm-view-open-item (car howm-items))))
    (goto-char (point-max))
    (unless (bolp) (insert ""))
    (insert
     (format "** [%04d-%02d-%02d]@ "
             (calendar-extract-year date)
             (calendar-extract-month date)
             (calendar-extract-day date)))))

(eval-after-load "howm-menu"
  '(progn
    (require 'calfw-howm)
    (cfw:install-howm-schedules)
    (define-key howm-mode-map (kbd "M-C") 'cfw:elscreen-open-howm-calendar)
    (define-key cfw:howm-schedule-map (kbd "i") 'my-cfw-open-schedule-buffer)
    (define-key cfw:howm-schedule-inline-keymap (kbd "i") 'my-cfw-open-schedule-buffer)
    ))

;; calfw-ical.el
(require 'calfw-ical)
(cfw:install-ical-schedules)
(setq cfw:ical-calendar-contents-sources '("http://www.google.com/calendar/ical/masahirokoga%40gmail.com/private-ee8d8a532a470504a86bc1def2ec5842/basic.ics"))

;; timeclock-x.el
;; (require 'timeclock-x)
;; (timeclock-modeline-display 1) ;; if you want modline display
;; (timeclock-initialize)
;; (define-key ctl-x-map "ti" 'timeclock-in)
;; (define-key ctl-x-map "to" 'timeclock-out)
;; (define-key ctl-x-map "tc" 'timeclock-change)
;; (define-key ctl-x-map "tr" 'timeclock-reread-log)
;; (define-key ctl-x-map "tu" 'timeclock-update-modeline)
;; (define-key ctl-x-map "tw" 'timeclock-when-to-leave-string)

;; popwin.el
;; https://github.com/m2ym/popwin-el
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(add-to-list 'load-path (expand-file-name "~/work/emacs/popwin-el"))
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(add-to-list 'popwin:special-display-config '(" *auto-async-byte-compile*" :height 5 :noselect t))
(add-to-list 'popwin:special-display-config '("*YaTeX-typesetting*"))
(add-to-list 'popwin:special-display-config '("*anything moccur*" :position top))

;; grep-a-lot
(require 'grep-a-lot nil t)
(grep-a-lot-setup-keys)
;;http://d.hatena.ne.jp/kitokitoki/20110213/p1
(defvar my-grep-a-lot-search-word nil)
(defun grep-a-lot-buffer-name (position)
  "Return name of grep-a-lot buffer at POSITION."
  (concat "*grep*<" my-grep-a-lot-search-word ">"))
(defadvice rgrep (before my-rgrep (regexp &optional files dir) activate)
  (setq my-grep-a-lot-search-word regexp))
(defadvice lgrep (before my-lgrep (regexp &optional files dir) activate)
  (setq my-grep-a-lot-search-word regexp))


;;
;; develop tool
;;

;; yasnippet
(add-to-list 'load-path (expand-file-name "~/work/emacs/yasnippet-0.6.1c"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/work/emacs/yasnippet-0.6.1c/snippets")

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

;; magit
(modify-coding-system-alist 'process "git" '(euc-jp-unix . utf-8-unix))


;; cscope
(require 'xcscope nil t)

;; gtags
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

;; gdb
(setq gdb-many-windows t)
;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))
;;; I/O バッファを表示
(setq gdb-use-separate-io-buffer t)
;;; t にすると mini buffer に値が表示される
(setq gud-tooltip-echo-area nil)

(global-set-key (kbd "M-<RET>") 'ns-toggle-fullscreen)
(setq mac-pass-control-to-system nil)
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; gccsence
(require 'gccsense nil t)

;; eldoc-extension.el
;; http://d.hatena.ne.jp/rubikitch/20090207/1233936430
(require 'eldoc)
(require 'eldoc-extension)
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;c-eldoc.el
(load "c-eldoc")
(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-idle-delay) 0.20)
            (c-turn-on-eldoc-mode)
            ))
;; http://www.emacswiki.org/emacs/ElDoc
(if (eq window-system 'ns)
    (defadvice eldoc-highlight-function-argument
      (around my-formatting (sym args index) compile activate preactivate)
      "Replace original to apply my style of formatting."
      ;; HACK: intercept the call to eldoc-docstring-format-sym-doc at the
      ;; end of the adviced function. This is obviously brittle, but the
      ;; alternative approach of copy/pasting the original also has
      ;; downsides...
      (flet ((eldoc-docstring-format-sym-doc
              (sym doc face)
              (let* ((function-name (propertize (symbol-name sym)
                                                'face face))
                     (spec (format "%s %s" function-name doc))
                     (docstring (or (eldoc-docstring-first-line
                                     (documentation sym t))
                                    "Undocumented."))
                     (docstring (propertize docstring
                                            'face 'font-lock-doc-face))
                     ;; TODO: currently it strips from the start of spec by
                     ;; character instead of whole arguments at a time.
                     (fulldoc (format "%s: %s" spec docstring))
                     (ea-width (1- (window-width (minibuffer-window)))))
                (cond ((or (<= (length fulldoc) ea-width)
                           (eq eldoc-echo-area-use-multiline-p t)
                           (and eldoc-echo-area-use-multiline-p
                                (> (length docstring) ea-width)))
                       fulldoc)
                      ((> (length docstring) ea-width)
                       (substring docstring 0 ea-width))
                      ((>= (- (length fulldoc) (length spec)) ea-width)
                       docstring)
                      (t
                       ;; Show the end of the partial symbol name, rather
                       ;; than the beginning, since the former is more likely
                       ;; to be unique given package namespace conventions.
                       (setq spec (substring spec (- (length fulldoc) ea-width)))
                       (format "%s: %s" spec docstring))))))
        ad-do-it)))


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


;; mode-compile.el
;; (autoload 'mode-compile "mode-compile"
;;  "Command to compile current buffer file based on the major mode" t)
;; (global-set-key "\C-cc" 'mode-compile)
;; (autoload 'mode-compile-kill "mode-compile"
;;  "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-ck" 'mode-compile-kill)

;; snippet
;;(require 'snippet nil t)


(require 'hatenahelper-mode nil t)

;; git-dwim
;; http://d.hatena.ne.jp/rubikitch/20100716/git
(require 'git-dwim nil t)
(global-set-key "\C-xvB" 'git-branch-next-action)

;; auto-complete-mode
;;auto-complete
(require 'auto-complete-config nil t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'verilog-mode)

;; http://d.hatena.ne.jp/rubikitch/20100423/bytecomp
(require 'auto-async-byte-compile nil t)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; ruby-mode
;;(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(require 'ruby-mode nil t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; rubydb3x
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; rspec-mode
(add-to-list 'load-path "~/work/emacs/rspec-mode")
(require 'rspec-mode nil t)
(add-to-list 'rspec-mode 'ruby-mode)
(setq rspec-use-rake-flag t)

;; ruby-electric 括弧の自動挿入
(require 'ruby-electric nil t)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block nil t)
;;(ruby-block-mode t)

;; rvm.el
;; http://github.com/senny/rvm.el.git
(add-to-list 'load-path "~/work/emacs/rvm.el/")
(require 'rvm nil t)

;; yari.el
(require 'yari nil t)
(defun ri-bind-key ()
  (local-set-key [f1] 'yari-anything))
(add-hook 'ruby-mode-hook 'ri-bind-key)

;; ri-emacs
;; https://github.com/pedz/ri-emacs.git
(add-to-list 'load-path (expand-file-name "~/work/emacs/ri-emacs/"))
(setq ri-ruby-script (expand-file-name "~/work/emacs/ri-emacs/ri-emacs.rb"))
(autoload 'ri "ri-ruby.el" "Execute `ri'." t)


;; autotest.el
(require 'autotest nil t)
(define-key ruby-mode-map "\C-c\C-a" 'autotest-switch)
(define-key shell-mode-map "\C-c\C-a" 'autotest-switch)

;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;; rsense
(setq rsense-home (expand-file-name "~/opt/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc/"))
(require 'rsense nil t)
(add-hook 'ruby-mode-hook
		  (lambda ()
			(local-set-key (kbd "C-c .") 'ac-complete-rsense)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))
(setq rsense-rurema-home (expand-file-name "~/opt/src/rurema"))

(require 'anything-rurima nil t)
(setq anything-rurima-index-file "~/src/rurema/rubydoc/rurima.e")

;;recent-ext
(require 'recentf-ext nil t)

;; load init file for darwin
(if (eq window-system 'ns)
    (load (expand-file-name "~/.emacs.d/darwin-init.el")))



(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js2-basic-offset 2)
 '(org-agenda-files nil t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;;