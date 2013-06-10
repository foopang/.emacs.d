(setq inhibit-splash-screen t)         ; hide welcome screen
(setq inhibit-startup-message t)
;;;(setq width (max width (+ (length str) 1)))   ;line numbers
(setq c-basic-offset 2) ; indents 2 chars                                                                                                              
(setq tab-width 2)          ; and 2 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces

(global-linum-mode t)

(set-frame-parameter (selected-frame) 'alpha '(85 50))
 (add-to-list 'default-frame-alist '(alpha 85 50))

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (load-file "~/.emacs.d/color-theme/themes/color-theme-blackboard.el")
     (color-theme-blackboard)))

(add-to-list 'load-path "~/.emacs.d/site-lisp")
;;(load "rc-php.el")
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
