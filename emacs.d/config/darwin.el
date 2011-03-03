;; -*- coding: utf-8 -*-

;; font
;; http://yamashita.dyndns.org/blog/inconsolata-as-a-programming-font/
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


;; ;; macにおけるIMEの設定
;; ;; http://tezfm.blogspot.com/2009/11/cocoa-emacs.html
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

(menu-bar-mode 1)

(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

(global-set-key (kbd "M-<RET>") 'ns-toggle-fullscreen)
(setq mac-pass-control-to-system nil)
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

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
