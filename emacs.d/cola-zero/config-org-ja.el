;; add japanese info
;; see also org-ja project
;; https://github.com/org-mode-doc-ja/org-ja
(when (require 'info nil t)
  (add-to-list 'Info-additional-directory-list
	       (expand-file-name "~/.emacs.d/vendor/org-ja/work/")))

(defun org-info-ja (&optional node)
  "(Japanese) Read documentation for Org-mode in the info system.
With optional NODE, go directly to that node."
  (interactive)
  (info (format "(org-ja)%s" (or node ""))))

