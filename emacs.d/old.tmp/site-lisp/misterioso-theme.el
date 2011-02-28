;;; misterioso-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 Sebastian Hermida.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(deftheme misterioso
  "Dark and misterioso")

(custom-theme-set-faces
 'misterioso
 '(default ((t (:background "#2d3743" :foreground "#e1e1e0"))))
 '(cursor ((t (:background "#FF6347" :foreground "#696969"))))
 '(region ((t (:background "#2d4948" :foreground "#e1e1e0"))))
 '(mode-line ((t (:background "#212931" :foreground "#eeeeec"))))
 '(mode-line-inactive ((t (:background "#878787" :foreground "#eeeeec"))))
 '(fringe ((t (:background "#2e3748"))))
 '(minibuffer-prompt ((t (:foreground "#729fcf" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "#23d7d7"))))
 '(font-lock-comment-face ((t (:foreground "#74af68"))))
 '(font-lock-constant-face ((t (:foreground "#008b8b"))))
 '(font-lock-function-name-face ((t (:foreground "#00ede1" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "#ffad29" :weight bold))))
 '(font-lock-string-face ((t (:foreground "#e67128"))))
 '(font-lock-type-face ((t (:foreground "#34cae2"))))
 '(font-lock-variable-name-face ((t (:foreground "#dbdb95"))))
 '(font-lock-warning-face ((t (:foreground "#ff4242" :weight bold))))
 '(isearch ((t (:background "#fcffad" :foreground "#000000"))))
 '(lazy-highlight ((t (:background "#338f86"))))
 '(link ((t (:foreground "#59e9ff" :underline t))))
 '(link-visited ((t (:foreground "#ed74cd" :underline t))))
 '(button ((t (:underline t))))
 '(header-line ((t (:background "#e5e5e5" :foreground "#333333")))))

(provide-theme 'misterioso)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; misterioso-theme.el  ends here
