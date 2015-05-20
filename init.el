;; (setq debug-on-error t)
(setq inhibit-splash-screen t)         ; hide welcome screen
(setq inhibit-startup-message t)
;;;(setq width (max width (+ (length str) 1)))   ;line numbers
(setq-default c-basic-offset 4) ; indents 4 chars
(setq-default c-basic-indent 4)
(setq-default tab-width 4)          ; and 4 char wide for TAB
(setq-default indent-tabs-mode nil) ; And force use of spaces
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(setq tab-stop-list (number-sequence 2 200 2))
(setq yaml-indent-offset 4)


;; Change "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; (require 'cedet-remove-builtin)
;; (cedet-remove-builtin)
;; (require 'cl)
;; (setq load-path (remove-if (lambda (x) (string-match-p "cedet" x)) load-path))

;; CEDET
(load-file "~/.emacs.d/cedet/cedet-devel-load.el")
(semantic-load-enable-excessive-code-helpers)      ; Enable prototype help and smart completion
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; Semantic
(global-semantic-idle-scheduler-mode)
(global-semantic-idle-completions-mode)
(global-semantic-decoration-mode)
(global-semantic-highlight-func-mode)
(global-semantic-show-unmatched-syntax-mode)

(semantic-mode 1)
(require 'semantic/ia)

;; Enable EDE (Project Management) features
(global-ede-mode 1)


;; CC-mode
(add-hook 'c-mode-common-hook '(lambda ()
        (setq ac-sources (append '(ac-source-semantic) ac-sources))
))

;; Load CEDET CONTRIB.
(load-file "~/.emacs.d/cedet/contrib/cedet-contrib-load.el")

;; (ede-php-root-mode 1)
;; (ede-php-root-project "Hypebeast"
;;                       :file "~/Sites/Hypebeast/composer.json")

(ede-php-root-project "Hypebeast"
                      :file "~/Sites/Hypebeast/composer.json"
                      :class-loaders '(:psr0 (("Hypebeast" . "src")
                                              ("HypebeastStore" . "src"))))


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

;; ido mode
(ido-mode 1)
(ido-everywhere 1)

(require 'linum)
(global-linum-mode t)
(line-number-mode -1)
(add-hook 'shell-mode-hook (lambda () (linum-mode -1)))

(require 'recentf)
(setq recentf-max-saved-items 200)
(recentf-mode t)

(set-frame-parameter (selected-frame) 'alpha '(90 80))
 (add-to-list 'default-frame-alist '(alpha 90 80))

(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 155))

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-deep-blue)))
;; (eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (load-file "~/.emacs.d/color-theme/themes/color-theme-blackboard.el")
;;     (color-theme-blackboard)))
;; (add-to-list 'load-path "~/.emacs.d/emacs-color-theme-dark-blue2")
;; (require 'color-theme-dark-blue2)
;; (color-theme-dark-blue2)

(add-to-list 'load-path "~/.emacs.d/site-lisp")
;;(load "rc-php.el")


;; PHP mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode 'php-enable-symfony2-coding-style)
;; edep
;; (add-to-list 'load-path "~/.emacs.d/edep")
;; (load "~/.emacs.d/edep/loaddefs.el")


;; (load (concat user-emacs-directory "drupal/drupal-init.el"))

(load (concat user-emacs-directory "markdown-mode/markdown-mode.el"))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(fringe-mode -1)
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(auto-save-mode -1)
(scroll-bar-mode -1)

;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
 "Never use tabs for alignment."
 (let ((indent-tabs-mode nil))
   ad-do-it))
(ad-activate 'align-regexp)
(global-set-key (kbd "C-c \\") 'align-regexp)

;; (Load (concat user-emacs-directory "sr-speedbar.el"))

;; (require 'sr-speedbar)
;; (global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; (when (string-match "^xterm" (getenv "TERM"))
;;   (load (concat user-emacs-directory "xterm-extras.el"))
;;   (require 'xterm-extras)
;;   (xterm-extra-keys))

;; package
(require 'package)
(package-initialize)


;; flx-ido
;; (require 'flx-ido)
;; (flx-ido-mode 1)
;; (setq ido-use-faces nil)


;; start auto-complete with emacs
(require 'auto-complete)
;; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; dirty fix for having AC everywhere
;; (define-globalized-minor-mode real-global-auto-complete-mode
;;   auto-complete-mode (lambda ()
;;                        (if (not (minibufferp (current-buffer)))
;;                            (auto-complete-mode 1))
;;                        ))
;; (real-global-auto-complete-mode t)
;; (global-auto-complete-mode)

;; SQL mode
(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'ac-modes 'nxml-mode)
(add-hook 'sql-mode-hook (lambda () (electric-indent-mode -1)))


;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)


;; web mode
(require 'web-mode)
(add-to-list 'web-mode-comment-formats '("php" . "//"))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.twig\\'" . web-mode))


;; Multiple cursors
(setq mc/list-file "~/.emacs.d/preferred/mc-lists.el")
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(defun create-cursor ()
  (interactive)
  (mc/create-fake-cursor-at-point))

(global-set-key (kbd "C-c C-,") 'create-cursor)
(global-set-key (kbd "C-c C-.") 'multiple-cursors-mode)


;;; activate ecb
(setq ecb-tip-of-the-day nil)
(require 'ecb)
(require 'ecb-autoloads)

;;; activate and deactivate ecb
(global-set-key (kbd "C-x C-;") 'ecb-activate)
(global-set-key (kbd "C-x C-'") 'ecb-deactivate)
;;; show/hide ecb window
(global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
(global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
;;; quick navigation between ecb windows
(global-set-key (kbd "C-)") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-!") 'ecb-goto-window-directories)
(global-set-key (kbd "C-@") 'ecb-goto-window-sources)
(global-set-key (kbd "C-#") 'ecb-goto-window-methods)
(global-set-key (kbd "C-$") 'ecb-goto-window-history)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes
   (quote
    (("left8"
      (ecb-directories-buffer-name 0.24516129032258063 . 0.28)
      (ecb-sources-buffer-name 0.24516129032258063 . 0.24)
      (ecb-methods-buffer-name 0.24516129032258063 . 0.28)
      (ecb-history-buffer-name 0.24516129032258063 . 0.18)))))
 '(ecb-options-version "2.40")
 '(eclim-eclipse-dirs (quote ("/Applications/eclipse")))
 '(eclim-executable "/Applications/eclipse/eclim")
 '(eclimd-default-workspace "~/Documents/workspace")
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(yaml-indent-offset 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; eclim
;; (require 'eclim)
;; (setq eclim-auto-save nil)
;; (global-eclim-mode -1)


;; add the emacs-eclim source
;; (when (global-eclim-mode 1)
;;     (require 'ac-emacs-eclim-source)
;;     (ac-emacs-eclim-config))


;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; Smartparens
;; (setq sp-highlight-pair-overlay nil)
;; (require 'smartparens-config)
;; (smartparens-global-mode)

;; Undo tree
(require 'undo-tree)
(global-undo-tree-mode)


;; Desktop save mode
(load (concat user-emacs-directory "custom-desktop-save-mode.el"))


;; custom key bindings
(load (concat user-emacs-directory "custom-key-bindings.el"))


;; Yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook (lambda () (electric-indent-mode 1)))

;; Show paren mode
(show-paren-mode 1)

;; Paredit
;; (require 'paredit)
;; (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))
;; (add-hook 'web-mode-hook (lambda () (paredit-mode 1)))

;; Electric Pair
(add-hook 'php-mode-hook (lambda () (electric-pair-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (electric-pair-mode 1)))
(add-hook 'web-mode-hook (lambda () (electric-pair-mode -1)))


;; Helm
;; (require 'helm-config)
;; (helm-mode 1)


;; Emmet-mode
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.


;; Projectile
(projectile-global-mode)
;; (setq projectile-enable-caching t)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Perspective mode
(with-eval-after-load "persp-mode-autoloads"
  (setq wg-morph-on nil) ;; switch off animation
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))
;; (persp-mode)
(require 'persp-projectile)


;; Workgroup2
;; (workgroups-mode 1)


;; Aggresive indent
(add-hook 'php-mode-hook #'Aggresive-indent-mode)


;; AG
(setq ag-highlight-search t)
