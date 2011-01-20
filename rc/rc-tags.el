;;; rc-tags.el --- 

;; Copyright (C) 2011  

;; Author:  <cire@cpp>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(setq path-to-ctags "ctags") ;; <- your ctags path here

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )

;; $ cd $proj
;; $ ( \
;;     find . '(' -type d -name .svn -o -name dist -o -name lib ')' -prune -o -type f\ 
;;     '(' -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.rc' ')' -print; \
;;     ls lib/xulrunner-sdk/include/plugin/np*.h; \
;;     ls lib/xulrunner-sdk/include/xpcom/*.h; \
;;     ls /usr/include/win32/win*.h; \
;;     ) | etags -

;; Or same with ctags:

;; $ cd $proj
;; $ ( \
;;     find . '(' -type d -name .svn -o -name dist -o -name lib ')' -prune -o -type f \
;;     '(' -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.rc' ')' -print; \
;;     ls lib/xulrunner-sdk/include/plugin/np*.h; \
;;     ls lib/xulrunner-sdk/include/xpcom/*.h; \
;;     ) | ctags --tag-relative=yes -e -L -
;; find /usr/local/lib/python2.7/dist-packages/ -name "*.py" |xargs ctags --tag-relative=yes -e

(require 'etags-select)
(require 'etags-table)
(setq etags-table-search-up-depth 10)
(setq etags-table-alist
      (list
       '(".*\\.py$" "~/.emacs.d/tags/TAGS")
       ))

;; (defun create-tags (dir-name)
;;   "Create tags file."
;;   (interactive "DDirectory: ")
;;   (eshell-command 
;;    (format "find %s -type f -name \"*.[ch]\" | etags -L -" dir-name)))


(provide 'rc-tags)
;;; rc-tags.el ends here
