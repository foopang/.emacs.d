;;; rc-org-mode.el --- 

;; Copyright (C) 2010  eric

;; Author: eric <eric@eric-desktop>
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
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/org/lisp")
(setq load-path (cons "~/.emacs.d/site-lisp/org-mode/lisp" load-path))
(setq load-path (cons "~/.emacs.d/site-lisp/org-mode/contrib/lisp" load-path))


(require 'org-install)
;;(require 'org)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done t)

(setq org-ditaa-jar-path (expand-file-name "~/.emacs.d/java/ditaa0_9.jar"))

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(setq org-babel-load-languages (quote ((emacs-lisp . t)
				       (dot . t)
				       (ditaa . t)
				       (R . t)
				       (python . t)
				       (ruby . t)
				       (gnuplot . t)
				       (clojure . t)
				       (sh . t))))

					; Do not prompt to confirm evaluation
					; This may be dangerous - make sure you understand the consequences
					; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

(provide 'rc-org-mode)
;;; rc-org-mode.el ends here
