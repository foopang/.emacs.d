(setq inhibit-splash-screen t)         ; hide welcome screen
(setq inhibit-startup-message t)
;;;(setq width (max width (+ (length str) 1)))   ;line numbers
(setq-default c-basic-offset 2) ; indents 2 chars
(setq-default c-basic-indent 2)
(setq-default tab-width 2)          ; and 2 char wide for TAB
;;(setq-default indent-tabs-mode nil) ; And force use of spaces
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(setq tab-stop-list (number-sequence 2 200 2))

(global-linum-mode t)

(set-frame-parameter (selected-frame) 'alpha '(90 80))
 (add-to-list 'default-frame-alist '(alpha 90 80))

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
;; (eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (load-file "~/.emacs.d/color-theme/themes/color-theme-blackboard.el")
;;     (color-theme-blackboard)))
(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
(require 'color-theme-solarized)
(color-theme-solarized-dark)

(add-to-list 'load-path "~/.emacs.d/site-lisp")
;;(load "rc-php.el")
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))


(load (concat user-emacs-directory "drupal/drupal-init.el"))

(load (concat user-emacs-directory "markdown-mode/markdown-mode.el"))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(tool-bar-mode -1)

;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

(load (concat user-emacs-directory "sr-speedbar.el"))

(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)