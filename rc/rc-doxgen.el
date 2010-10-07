;;; rc-doxgen.el --- 

;; Copyright (C) 2010  Eric

;; Author: Eric <eric@eric-desktop>
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
(add-to-list 'load-path
	     "~/.emacs.d/site-lisp/doxymacs/lisp")
(require 'doxymacs)

(add-hook 'c-mode-common-hook 'doxymacs-mode)

(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode) (eq major-mode 'php-mode) )
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)



(provide 'rc-doxgen)
;;; rc-doxgen.el ends here
