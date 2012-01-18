(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/org-mode/contrib/lisp"))
(add-to-list `auto-mode-alist '("\\.org$" . org-mode))

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)

;; org-capture
(if (eq window-system 'w32)
    (setq org-directory (expand-file-name "~/Documents/My Dropbox/memo/"))
    (setq org-directory (expand-file-name "~/Dropbox/memo/")))
(setq org-default-notes-file (concat org-directory "mygtd.org"))
(setq org-agenda-files '("~/Dropbox/memo/mygtd.org"))
(add-to-list 'org-agenda-files (concat org-directory "journal.org"))
;; (setq org-agenda-files ((concat org-directory "mygtd.org")
;;                         (concat org-directory "journal.org")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "mygtd.org") "Tasks")
         "* INBOX %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree (concat org-directory "journal.org"))
         "* %?\nEntered on %U\n %i\n %a")
        ("w" "Want" entry (file+datetree (concat org-directory "journal.org"))
         "* %? :Want:\nEntered on %U\n %i\n %a")))

(setq org-todo-keywords '((sequence "INBOX(i)" "NEXT-ACTION(n)"
                                    "INACTIVE(I)" "WAIT(W)"
                                    "PROJECT(p)" "|" "DONE(d)")))
(setq org-fast-tag-selection-include-todo t)

;; MobileOrg
(if (eq window-system 'w32)
	(progn
	 (setq org-mobile-directory "z:/org/")
	 (setq org-mobile-inbox-for-pull (concat org-directory "mobile.org")))
	(progn
          (setq org-mobile-files org-agenda-files)
          (setq org-mobile-directory (expand-file-name "~/Dropbox/MobileOrg/"))
          (setq org-mobile-inbox-for-pull (concat org-directory "mobile.org"))))

;; org-export-general.el
(require 'org-export-generic)

;; org-protocol
(require 'org-protocol)

;;[[http://hpcgi1.nifty.com/spen/?OrgMode%252FOrgForGTD#i26][OrgMode/OrgForGTD - Org-mode¤ÇGTD:Google Chrome]]
(defun gtd ()
  (interactive)
  (find-file (concat org-directory "mygtd.org")))
(global-set-key "\M-9" 'gtd)
(defun journal ()
  (interactive)
  (find-file (concat org-directory "journal.org")))
(global-set-key "\M-0" 'journal)
