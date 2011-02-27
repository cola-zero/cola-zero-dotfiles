
(prefer-coding-system 'utf-8)
(set-frame-parameter nil 'alpha 90)

;; anything find file
(setq anything-c-filelist-file-name "/tmp/mnt/all.filelist")


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


;; exec-path を設定しないと実行できない場合があります
(setq exec-path
     (append
      (list "/usr/local/bin" "/sw/bin" "/usr/bin" "~/bin") exec-path)
     )
;; PATHが正しくとおっていないとフルパスで呼ばないといけなくなります
(setenv "PATH"
       (concat '"/usr/local/bin:/sw/bin:" (getenv "PATH"))
       )
;; dictionary.app
(defun dictionary ()
  "dictionary.app"
  (interactive)

 (let ((editable (not buffer-read-only))
       (pt (save-excursion (mouse-set-point last-nonmenu-event)))
       beg end)

   (if (and mark-active
            (<= (region-beginning) pt) (<= pt (region-end)) )
       (setq beg (region-beginning)
             end (region-end))
     (save-excursion
       (goto-char pt)
       (setq end (progn (forward-word) (point)))
       (setq beg (progn (backward-word) (point)))
       ))

   (setq word (buffer-substring-no-properties beg end))
   (let ((win (selected-window))
         (tmpbuf " * dict-process *"))
     (pop-to-buffer tmpbuf)
     (erase-buffer)
     (insert word "\n")
     (start-process "dict-process" tmpbuf "dict.py" word)
     (select-window win)
     )
 ))
 (define-key global-map (kbd "C-c w") 'dictionary)

;; 辞書の結果をpopwin.elで表示
(push '(" * dict-process *" :height 30 :noselect t) popwin:special-display-config)

;; ツールチップで表示
;; http://d.hatena.ne.jp/tomoya/20091218/1261138091
(defun ns-popup-dictionary ()
   "カーソル付近の単語を Mac の辞書でひく"
   (interactive)
   (let ((word (substring-no-properties (thing-at-point 'word)))
	 (old-buf (current-buffer))
	 (dict-buf (get-buffer-create "*dictionary.app*"))
	 (view-mode-p)
	 (dict))
     (set-buffer dict-buf)
     (erase-buffer)
     (call-process "dict.py"
		   nil "*dictionary.app*" t word
		   "Japanese-English" "Japanese" "Japanese Synonyms")
     (setq dict (buffer-string))
     (set-buffer old-buf)
     (when view-mode
       (view-mode)
       (setq view-mode-p t))
     (popup-tip dict)
     (when view-mode-p
       (view-mode))))

(define-key global-map (kbd "C-M-d") 'ns-popup-dictionary)


;;font
;;http://yamashita.dyndns.org/blog/inconsolata-as-a-programming-font/
;; (set-default-font "Inconsolata-11")
;; (set-face-font 'variable-pitch "Inconsolata-11")
(add-hook 'window-setup-hook
          (lambda nil
            ;; font setting
            ;; (set-default-font "Inconsolata-12")
            ;; (set-face-font 'variable-pitch "Inconsolata-12")
            (set-face-font 'variable-pitch "Droid Sans Mono Slashed-12")
            (set-fontset-font (frame-parameter nil 'font)
                              'japanese-jisx0208
                              ;; '("Takaoゴシック" . "unicode-bmp"))
                              '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
            ;; 半角カナのために↓を追加
            (set-fontset-font
             (frame-parameter nil 'font)
             'katakana-jisx0201
             '("Hiragino Maru Gothic Pro" . "iso10646-1"))
            ;; asciiと日本語fontを1:2にするために
            (setq face-font-rescale-alist
                  '(("^-apple-hiragino.*" . 1.2)
                    (".*osaka-bold.*" . 1.2)
                    (".*osaka-medium.*" . 1.2)
                    (".*courier-bold-.*-mac-roman" . 1.0)
                    (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                    (".*monaco-bold-.*-mac-roman" . 0.9)
                    ("-cdac$" . 1.3)
                    (".*Takao*" . 2.0)))))

;; haml-mode
(add-to-list 'load-path (expand-file-name "~/work/emacs/haml-mode/"))
(require 'haml-mode)


;; slime
(load "~/.emacs.d/my-slime.el")
(setq inferior-lisp-program "~/opt/sbcl/bin/sbcl") ; your Lisp system
(add-to-list 'load-path "~/work/emacs/slime/") ; your SLIME directory
(require 'slime)
(slime-setup)

;Hyperspec
(require 'hyperspec)
(setq common-lisp-hyeprspec-root (concat "file://" (expand-file-name "~/opt/doc/Hyperspec/"))
      common-lisp-hyperspec-symbol-table (expand-file-name "~/doc/HyperSpec/Data/Map_Sym.txt"))

;; HyperSpecをw3mで見る
;; http://d.hatena.ne.jp/khiker/20061231/1167567844
(defadvice common-lisp-hyperspec
  (around hyperspec-lookup-w3m () activate)
  (let* ((window-configuration (current-window-configuration))
         (browse-url-browser-function
          `(lambda (url new-window)
             (w3m-browse-url url nil)
             (let ((hs-map (copy-keymap w3m-mode-map)))
               (define-key hs-map (kbd "q")
                 (lambda ()
                   (interactive)
                   (kill-buffer nil)
                   (set-window-configuration ,window-configuration)))
               (use-local-map hs-map)))))
    ad-do-it))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; haskell-mode
(load "~/.emacs.d/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(setq haskell-program-name "/usr/local/bin/ghci")

;; go-mode
;; (add-to-list 'load-path (expand-file-name "~/opt/go/misc/emacs/"))
;; (require 'go-mode-load)


;; scala-mode
;; (add-to-list 'load-path "/usr/local/Cellar/scala/2.8.1/libexec/misc/scala-tool-support/emacs")
;; (require 'scala-mode-auto)
;; (scala-mode-electric)

;; ocaml-mode
(add-to-list 'load-path (expand-file-name "~/opt/src/ocaml-3.12.0/emacs/"))
(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
;; tuareg-mode
(add-to-list 'load-path (expand-file-name "~/opt/src/ocaml-3.12.0/emacs/tuareg-mode"))
(load (expand-file-name "~/opt/src/ocaml-3.12.0/emacs/tuareg-mode/append-tuareg.el"))
(add-to-list 'exec-path (expand-file-name "~/opt/ocaml/bin"))

;; xml-rpc
(require 'xml-rpc nil t)

;; weblogger-el
(require 'weblogger nil t)
(setq weblogger-save-password t)
(setq weblogger-save-entry t)
;; (load (expand-file-name "~/.emacs.d/local.elc"))

;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
; fixing indentation
; refer to http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
(autoload 'espresso-mode "espresso")

(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 4
        indent-tabs-mode nil
        c-basic-offset 4)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  ; (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map "\C-\M-\\"
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map "\C-m" 'newline-and-indent)
  ; (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  ; (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map "\C-\M-q" 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
      (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)


