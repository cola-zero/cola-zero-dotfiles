; -*- coding: utf-8 -*-
;org-mode
(package-install 'orgmode '((files . ("org-mode"))
                            (additional-paths . ("lisp" "contrib")))
                 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list `auto-mode-alist '("\\.org$" . org-mode))
(setq org-tag-alist
	  '(("@LABO" . ?l) ("@HOME" . ?h) ("@PROJECT" . ?p) ("@COMPUTER" . ?c) ("@READING" . ?r)))
;; (org-remember-insinuate)
(if (eq window-system 'w32)
    (setq org-directory "~/Documents/My Dropbox/memo/")
    (setq org-directory "~/Dropbox/memo/"))
(setq org-default-notes-file (concat org-directory "mygtd.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "mygtd.org") "Tasks")
         "* INBOX %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/Dropbox/memo/journal.org")
         "* %?\nEntered on %U\n %i\n %a")
        ("w" "Want" entry (file+datetree "~/Dropbox/memo/journal.org")
         "* %? :Want:\nEntered on %U\n %i\n %a")
        ("b" "Blog" entry (file+headline (concat org-directory "blog.org") "Entry")
         "* %?\n")))

(global-set-key "\C-ca" 'org-agenda)

(defvar org-code-reading-software-name nil)
;; ~/memo/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: "
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"
		  "[" hostname "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
             ,org-code-reading-file "Memo"))))
    (org-remember)))

(setq org-agenda-files (list (concat org-directory "agenda.org")
                             (concat org-directory "code-reading.org")
                             (concat org-directory "blog.org")))

;MobileOrg
(if (eq window-system 'w32)
	(progn
	 (setq org-mobile-directory "z:/org/")
	 (setq org-mobile-inbox-for-pull "~/Documents/My Dropbox/memo/mobile.org"))
	(progn
          (setq org-mobile-files org-agenda-files)
          (setq org-mobile-directory "~/Dropbox/MobileOrg/")
          (setq org-mobile-inbox-for-pull "~/Dropbox/memo/mobile.org")))
(setq org-todo-keywords '((sequence "INBOX(i)" "NEXT-ACTION(n)" "INACTIVE(I)" "WAIT(W)" "PROJECT(p)" "|" "DONE(d)")))
(setq org-fast-tag-selection-include-todo t)

;diary
;; (setq diary-file "~/memo/diary.gpg")
(setq org-agenda-include-diary t)
(setq auto-mode-alist
	  (cons (cons "diary" 'org-mode) auto-mode-alist))

;custom agenda view
(setq org-agenda-custom-commands
	  '(("s" tags "Want")
		("c" "Weekly schedule" agenda ""
         ((org-agenda-ndays 7)          ;; agenda will start in week view
          (org-agenda-repeating-timestamp-show-all t)   ;; ensures that repeating events appear on all relevant dates
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
		("d" "Upcoming deadlines" agenda ""
         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
          (org-agenda-ndays 1)
          (org-deadline-warning-days 60)
          (org-agenda-time-grid nil)))
		("O" "MobileOrg agenda"
		 ((agenda "" ((org-agenda-ndays 1)))
		  (todo "PROJECT")
		  (todo "TODO")
		  (todo "NEXT-ACTION")
		  (todo "WAIT")
          (todo "LABO")
          (todo "COMPUTER")
          (todo "READING"))
		 ((org-agenda-compact-blocks t)))
		))

;; anything-org-mode
(package-install 'gist "746084" 'anything-org-mode)

(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
(setq org-startup-folded nil)
