;; Make buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


;; Don't show the startup message
(setq inhibit-startup-message t)


;; Save backup files in the temporary directory
(setq backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


;; Shorten yes/no answers to y/n
(fset 'yes-or-no-p 'y-or-n-p)


;; Automatically update buffers when files change
(global-auto-revert-mode t)


;; Enable 'power user' features
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)


(defun graphene-look-startup-after-init ()
  "Load defaults for the overall Graphene look -- to be called after loading the init file so as to pick up custom settings."
  (if window-system
      (progn
        (load-file (expand-file-name "graphene-theme.el" theme-dir))
        (require 'graphene-theme)
        (load-theme 'graphene t)
        (defadvice load-theme
          (after load-graphene-theme (theme &optional no-confirm no-enable) activate)
          "Load the graphene theme extensions after loading a theme."
          (when (not (equal theme 'graphene))
            (load-theme 'graphene t))))
    (when (not (eq system-type 'darwin))
      (menu-bar-mode -1))
    ;; Menu bar always off in text mode
    (menu-bar-mode -1)))

(add-hook 'after-init-hook 'graphene-look-startup-after-init)

;; Editing

;; Main hook to be run on entering de facto prog modes
(add-hook 'graphene-prog-mode-hook
          (lambda ()
            (electric-indent-mode t)
            (electric-pair-local-mode t)
            (show-paren-mode nil)
            (linum-mode t)

            (require 'flycheck)
            (flycheck-mode)))

;; Attach de facto prog mode hooks after loading init file
(add-hook 'after-init-hook
          (lambda ()
            (dolist (hook '(prog-mode-hook csharp-mode-hook coffee-mode-hook css-mode-hook sgml-mode-hook html-mode-hook yaml-mode-hook nxml-mode-hook vue-mode-hook))
              (add-hook hook (lambda () (run-hooks 'graphene-prog-mode-hook))))))

(eval-after-load 'flycheck
  '(progn
     (defun graphene--flycheck-display-errors-function (errors)
       (mapc (lambda (err)
               (message "FlyC: %s" (flycheck-error-message err)) (sit-for 1))
             errors))
     (setq flycheck-highlighting-mode nil
           flycheck-display-errors-function 'graphene--flycheck-display-errors-function)))

;; Character encodings default to utf-8.
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; apply syntax highlighting to all buffers
(global-font-lock-mode t)

;; global subword mode
(global-subword-mode t)

;; auto json-mode
(push '("\\.json\\'" . json-mode) auto-mode-alist)

;; recentf
(recentf-mode t)

;; SQL mode
(add-hook 'sql-mode-hook (lambda () (electric-indent-local-mode nil)))

;; JS mode
(add-hook 'custom-set-current-indentation-hook '(lambda() (setq js-indent-level tab-width)))

(add-hook 'find-file-hook (lambda()
                            ;; Elixir template
                            (when (and (stringp buffer-file-name)
                                       (string-match "\\.html.eex\\'" buffer-file-name))
                              (custom-set-current-indentation 2)
                              (set (make-local-variable 'web-mode-markup-indent-offset) 2))))

(provide 'custom-env)
