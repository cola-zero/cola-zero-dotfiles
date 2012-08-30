(require 'org-publish)
(setq org-publish-project-alist
   '(("blog" .  (:base-directory "~/work/blog.mkoga.net/source/_org_posts/"
                 :base-extension "org"
                 :publishing-directory "~/work/blog.mkoga.net/source/_posts/"
                 :sub-superscript ""
                 :recursive t
                 :publishing-function org-publish-org-to-html
                 :headline-levels 4
                 :html-extension "markdown"
                 :body-only t))))

(defun auto-export-my-blog ()
  (let* ((project-plist (cdr (assoc "blog" org-publish-project-alist)))
         (project-dir (expand-file-name
                       (plist-get project-plist :base-directory))))
    (save-excursion
      (if (string= project-dir (file-name-directory buffer-file-name))
          (org-publish-current-file)))))

(add-hook 'after-save-hook
          'auto-export-my-blog)

(provide 'config-org-octopress)
