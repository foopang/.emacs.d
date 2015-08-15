;;; init.el --- Emacs initiliazation

;;; Commentary:

;;; Emacs initialization

;;; Code:

(setq indent-line-function 'insert-tab)

(setq semantic-ctags-program "/usr/local/bin/ctags")

;; Set path for theme directory
(defvar custom-dir (expand-file-name "custom" user-emacs-directory))
(defvar site-lisp-dir (expand-file-name "site-lisp" user-emacs-directory))
(defvar theme-dir (expand-file-name "themes" user-emacs-directory))


;; Enable commands
(put 'scroll-left 'disabled nil)

;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Add package manager configuration
(eval-and-compile
  (package-initialize nil)

  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

  (unless (file-exists-p (expand-file-name "elpa/archives/gnu" user-emacs-directory))
    (package-refresh-contents))

  (unless (file-exists-p (expand-file-name "elpa/archives/marmalade" user-emacs-directory))
    (package-refresh-contents))

  (unless (file-exists-p (expand-file-name "elpa/archives/melpa" user-emacs-directory))
    (package-refresh-contents))

  (unless (file-exists-p (expand-file-name "elpa/archives/melpa-stable" user-emacs-directory))
     (package-refresh-contents))

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (defvar use-package-verbose t)

  (require 'cl)
  (require 'use-package))

;; theme
(load-file (expand-file-name "material-theme.el" theme-dir))

;; custom file
(setq custom-file (expand-file-name "preferences.el" user-emacs-directory))
(load custom-file)

;; recentf
(recentf-mode t)

;; SQL mode
(add-hook 'sql-mode-hook (lambda () (electric-indent-local-mode nil)))

;; Set up load path
(add-to-list 'load-path custom-dir)

(require 'custom-packages)
(require 'custom-funcs)
(require 'custom-key-bindings)
(require 'linum-off)
