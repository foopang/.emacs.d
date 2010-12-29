;;; rc-javascript.el --- 

;; Copyright (C) 2010  

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
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))


;; must be compiled before loaded
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))



;; MozRepl
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'espresso-mode-hook 'espresso-custom-setup)
(defun espresso-custom-setup ()
  (moz-minor-mode 1))

(provide 'rc-javascript)
;;; rc-javascript.el ends here

