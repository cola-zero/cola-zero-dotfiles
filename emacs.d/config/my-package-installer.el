;; my-package-installer

(require 'cl)

(defvar package-base-dir "~/.emacs.d/packages")

(defun package-path-basename (path)
  (file-name-sans-extension (file-name-nondirectory path)))

(defun package-directory (files)
  (concat package-base-dir "/"
          (package-path-basename (car files))))

(defun package-run-shell-command (command)
  (message (format "running...: %s" command))
  (shell-command command))

(defun package-install-from-coderepos (files)
  (shell-command
   (format (concat "svn co http://svn.coderepos.org/share/lang/elisp/%s/trunk %s")
           (car files)
           (package-directory files))))

(defun package-install-from-yasnippet (files)
  (shell-command
   (format (concat "svn checkout http://yasnippet.googlecode.com/svn/trunk/ %s")
           (package-directory files))))

(defun package-install-from-orgmode (files)
  (shell-command
   (format (concat "git clone git://orgmode.org/org-mode.git %s")
           (package-directory files))))

(defun package-install-from-emacswiki (files)
  (shell-command
   (format "mkdir -p %s" (package-directory files)))
  (package-run-shell-command
   (format "wget --directory-prefix %s %s"
           (package-directory files)
           (mapconcat (lambda (name)
                        (concat "http://www.emacswiki.org/emacs/download/"
                                name))
                      files
                      " "))))

(defun package-install-from-gist (gistid)
  (package-run-shell-command
   (format (concat "git clone git://gist.github.com/%s.git %s")
           (car files)
           (package-directory files))))

(defun package-install-from-github (files)
  (package-run-shell-command
   (format (concat "git clone https://github.com/%s.git %s")
           (car files)
           (package-directory files))))

(defun package-install-from-repo.or.cz (files)
  (package-run-shell-command
   (format (concat "git clone git://repo.or.cz/%s.git %s")
           (car files)
           (package-directory files))))

(defun package-alist-value (alist key default-value)
  (if (listp alist)
      (let ((alist-item (assoc key alist)))
        (if alist-item
            (cdr alist-item)
          default-value))
    default-value))

(defun my-package-install (type package-spec require-name &optional force)
  (let ((files (package-alist-value package-spec 'files
                                    (if (listp package-spec)
                                        package-spec
                                      (list package-spec))))
        (base-path (package-alist-value package-spec 'base-path "."))
        (additional-paths (package-alist-value package-spec 'additional-paths
                                               nil))
        (install-proc (case type
                        (yasnippet
                         'package-install-from-yasnippet)
                        (orgmode
                         'package-install-from-orgmode)
                        (coderepos
                         'package-install-from-coderepos)
                        (emacswiki
                         'package-install-from-emacswiki)
                        (github
                         'package-install-from-github)
                        (gist
                         'package-install-from-gist)
                        (repo.or.cz
                         'package-install-from-repo.or.cz)
                        (t
                         (error "unknown package type: <%s>(%s)"
                                type package)))))
    (add-to-list 'load-path
                 (format "%s/%s"
                         (package-directory files)
                         base-path))
    (dolist (additional-path additional-paths)
      (add-to-list 'load-path (format "%s/%s"
                                      (package-directory files)
                                      additional-path)))
    (condition-case err
        (require require-name)
      (error
       (message (format "installing %s..." files))
       (funcall install-proc files)))
    (require require-name)))
