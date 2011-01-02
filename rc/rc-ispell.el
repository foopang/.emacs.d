;;; rc-ispell.el --- 

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

;;(if (file-exists-p "/usr/bin/hunspell")                                         
;;    (progn
;;      (setq ispell-program-name "hunspell")
;;      (eval-after-load "ispell"
;;        '(progn (defun ispell-get-coding-system () 'utf-8)))))

;;(setq ispell-local-dictionary "en_US")


;;(require 'rw-hunspell)


;;(require 'rw-ispell)
;;(rw-ispell-set-up-pdicts)

;;(require 'rw-language-and-country-codes)

;; Use hunspell instead of ispell
;;;(require 'rw-language-and-country-codes)
;;;(require 'rw-ispell)
;;;(require 'rw-hunspell)
;;;(setq ispell-dictionary "en_US")
;; The following is set via custom
;;;(custom-set-variables
;;; '(rw-hunspell-default-dictionary "en_US")
;;; '(rw-hunspell-dicpath-list (quote ("/usr/share/myspell")))
;;; '(rw-hunspell-make-dictionary-menu t)
;;; '(rw-hunspell-use-rw-ispell t)
;;; )
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(require 'ispell)

(ispell-set-spellchecker-params)
(setq ispell-dictionary "en_US")
(setq ispell-really-hunspell t)
(setq ispell-program-name "hunspell")
(setq ispell-last-program-name ispell-program-name)

(setq ispell-local-dictionary-alist
      '(
	;; default
	(nil
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil iso-8859-1)

	;; Yankee English
	("en_US"
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil utf-8)

	;; Spanish mode
	("castellano"
	 "[a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]" "[^a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]"
	 "[-]" nil ("-B") "~tex" iso-8859-1)

	;; standard French
	("fr_FR"
	 "[a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]" "[^a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]"
	 "[-']" t nil "~list" utf-8)

	;; Nederlands.aff
	("nederlands"
	 "[a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]" "[^a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]"
	 "[']" t ("-C") nil iso-8859-1)
	))
(setq ispell-dictionary-alist
      '(
	;; default
	(nil
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil iso-8859-1)

	;; Yankee English
	("en_US"
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil utf-8)

	;; Spanish mode
	("castellano"
	 "[a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]" "[^a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]"
	 "[-]" nil ("-B") "~tex" iso-8859-1)

	;; standard French
	("fr_FR"
	 "[a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]" "[^a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]"
	 "[-']" t nil "~list" utf-8)

	;; Nederlands.aff
	("nederlands"
	 "[a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]" "[^a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]"
	 "[']" t ("-C") nil iso-8859-1)
	))

(custom-set-variables
'(ispell-dictionary-alist
      (quote (
	;; default
	(nil
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil iso-8859-1)

	;; Yankee English
	("en_US"
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil utf-8)

	;; Spanish mode
	("castellano"
	 "[a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]" "[^a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]"
	 "[-]" nil ("-B") "~tex" iso-8859-1)

	;; standard French
	("fr_FR"
	 "[a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]" "[^a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]"
	 "[-']" t nil "~list" utf-8)

	;; Nederlands.aff
	("nederlands"
	 "[a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]" "[^a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]"
	 "[']" t ("-C") nil iso-8859-1)
	))))

;;;(rw-hunspell-setup)
;;;(rw-ispell-set-up-pdicts)
;;;(require 'rw-language-and-country-codes)


(eval-after-load "ispell"
  ;; so that following modifications won't be lost when ispell is loaded
  '(progn
     (setq ispell-program-name "hunspell")
     (setq ispell-dictionary "en_US")
     (setq ispell-dictionary-alist
      '(
	;; default
	(nil
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil iso-8859-1)

	;; Yankee English
	("en_US"
	 "[A-Za-z]" "[^A-Za-z]"
	 "[']" nil ("-B") nil utf-8)

	;; Spanish mode
	("castellano"
	 "[a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]" "[^a-zñáàéèíìóòúùüA-ZÑÁÀÉÈÍÌÓÒÚÙÜ]"
	 "[-]" nil ("-B") "~tex" iso-8859-1)

	;; standard French
	("fr_FR"
	 "[a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]" "[^a-zàâäéèêëîïôöùûüçA-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]"
	 "[-']" t nil "~list" utf-8)

	;; Nederlands.aff
	("nederlands"
	 "[a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]" "[^a-zàâçëîïôùûüA-ZÀÂÇËÎÏÔÙÛÜ]"
	 "[']" t ("-C") nil iso-8859-1)
	))
))



(provide 'rc-ispell)
;;; rc-ispell.el ends here
