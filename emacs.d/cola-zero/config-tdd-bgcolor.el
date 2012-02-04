;; http://diary.overlasting.net/cat_emacs.html
(defvar tdd-bgcolor-alist
      '(("Think"      ."black")
	 ("Red"        ."#ff4444")
	 ("Green"      ."#44dd44")
	 ("Refactoring"."#ffaa44")))

(defvar tdd-bgcolor-mode 3)
(defvar tdd-bgcolor-mode-name "")
(let (
      (cell (or (memq 'mode-line-position mode-line-format)
		 (memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr 'tdd-bgcolor-mode-name))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun tdd-bgcolor-rotate ()
  (interactive)
  (let (pair)
    (if (>= tdd-bgcolor-mode 3)
	 (setq tdd-bgcolor-mode 0)
      (setq tdd-bgcolor-mode
		 (+ tdd-bgcolor-mode 1)))
    (setq pair
      (nth tdd-bgcolor-mode tdd-bgcolor-alist))
    (setq tdd-bgcolor-mode-name (format "[%s]" (car pair)))
    (message tdd-bgcolor-mode-name)
    (set-face-foreground 'mode-line (cdr pair))))

(global-set-key "\C-c\C-m" 'tdd-bgcolor-rotate)

(provide 'config-tdd-bgcolor)
