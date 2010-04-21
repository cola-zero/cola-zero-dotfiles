;org-mode
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list `auto-mode-alist '("\\.org$" . org-mode))
(setq org-tag-alist
	  '(("@work" . ?w) ("@home" . ?h) ("@shopping" . ?s)))
(org-remember-insinuate)
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-remember-templates
	  '(("Todo" ?t "** INBOX %?\n %i\n %a\n %t" nil "Inbox")
		("Idea" ?i "** %?\n %i\n %a\n %t" nil "New Ideas")
		("Note" ?n "** NOTE %?\n %i\n %a\n %t" nil "Note")
		("Shopping" ?s "** %? :@shopping:\n %i\n%t" nil "Inbox")
		))
(global-set-key "\C-x\C-x" 'org-remember)
(global-set-key "\C-x\C-r" 'org-remember-code-reading)
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

(setq org-agenda-files (list "~/memo/agenda.org"
							 "~/memo/code-reading.org"))

;MobileOrg
(setq org-mobile-directory "/Volumes/cola-zero/org/")
(setq org-mobile-inbox-for-pull "~/memo/mobile.org")
(setq org-todo-keywords '((sequence "INBOX" "NEXT-ACTION" "WAIT" "PROJECT" "|" "DONE")))

;diary
 (setq diary-file "~/memo/diary.gpg")

;custom agenda view
(setq org-agenda-custom-commands
	  '(("s" tags "@shopping")
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
		  (todo "WAIT"))
		 ((org-agenda-compact-blocks t)))
		))
