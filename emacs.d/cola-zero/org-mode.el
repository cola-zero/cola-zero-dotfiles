(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/org-mode/contrib/lisp"))
(add-to-list `auto-mode-alist '("\\.org$" . org-mode))

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)

;; org-capture
(if (eq window-system 'w32)
    (setq org-directory "~/Documents/My Dropbox/memo/")
    (setq org-directory "~/Dropbox/memo/"))
(setq org-default-notes-file (concat org-directory "mygtd.org"))
(add-to-list 'org-agenda-files org-default-notes-file)
(add-to-list 'org-agenda-files (concat org-directory "journal.org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "mygtd.org") "Tasks")
         "* INBOX %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/Dropbox/memo/journal.org")
         "* %?\nEntered on %U\n %i\n %a")
        ("w" "Want" entry (file+datetree "~/Dropbox/memo/journal.org")
         "* %? :Want:\nEntered on %U\n %i\n %a")))

(setq org-todo-keywords '((sequence "INBOX(i)" "NEXT-ACTION(n)"
                                    "INACTIVE(I)" "WAIT(W)"
                                    "PROJECT(p)" "|" "DONE(d)")))
(setq org-fast-tag-selection-include-todo t)

;; MobileOrg
(if (eq window-system 'w32)
	(progn
	 (setq org-mobile-directory "z:/org/")
	 (setq org-mobile-inbox-for-pull "~/Documents/My Dropbox/memo/mobile.org"))
	(progn
          (setq org-mobile-files org-agenda-files)
          (setq org-mobile-directory "~/Dropbox/MobileOrg/")
          (setq org-mobile-inbox-for-pull "~/Dropbox/memo/mobile.org")))

;; org-export-general.el
(require 'org-export-generic)

;; org-protocol
(require 'org-protocol)

;;[[http://hpcgi1.nifty.com/spen/?OrgMode%252FOrgForGTD#i26][OrgMode/OrgForGTD - Org-mode¤ÇGTD:Google Chrome]]
(defun gtd ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/memo/mygtd.org")))
(global-set-key "\M-9" 'gtd)
(defun journal ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/memo/journal.org")))
(global-set-key "\M-0" 'journal)
