(column-number-mode t)
(line-number-mode t)

;; ステータスラインに時間を表示する
(if (>= emacs-major-version 22)
    (progn
      (setq dayname-j-alist
            '(("Sun" . "日") ("Mon" . "月") ("Tue" . "火") ("Wed" . "水")
              ("Thu" . "木") ("Fri" . "金") ("Sat" . "土")))
      (setq display-time-string-forms
            '((format "%s年%s月%s日(%s) %s:%s"
                      year month day
                      (cdr (assoc dayname dayname-j-alist))
                      24-hours minutes)))
      ))
(display-time)

;; 行番号を表示
(line-number-mode t)

(provide 'config-mode-line)
