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
  (let* ((project (assoc "blog" org-publish-project-alist))
         (files (org-publish-get-base-files project)))
    (if (member buffer-file-name files)
       (org-publish-current-file))))

(add-hook 'after-save-hook
          'auto-export-my-blog)

(provide 'config-org-octopress)
