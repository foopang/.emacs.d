;;; rc-lisp.el --- 

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

(add-to-list 'load-path "~/.emacs.d/site-lisp/slime")  ; your SLIME directory
(setq inferior-lisp-program "sbcl") ; your Lisp system
(require 'slime)
;;(slime-setup)
;;(slime-setup '(slime-fancy))
(slime-setup '(slime-fancy slime-asdf))

(add-hook 'sldb-mode-hook #'(lambda () (setq autopair-dont-activate t)))
(define-key global-map (kbd "<f12>") 'slime-selector)

(provide 'rc-lisp)
;;; rc-lisp.el ends here