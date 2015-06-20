(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
;; (setq package-enable-at-startup nil)

(setq semantic-ectags-program "/usr/local/bin/ctags")

;; smooth scrolling
;; (setq scroll-step 1
;;       scroll-conservatively 10000
;;       auto-window-vscroll nil)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(setq package-list '(ag s dash aggressive-indent names auto-complete popup ecb emacs-eclim s emmet-mode etags-select expand-region feature-mode flatland-theme flx-ido flx graphene company flycheck let-alist pkg-info epl dash smartparens dash web-mode smex sr-speedbar ppd-sr-speedbar project-persist-drawer project-persist sr-speedbar exec-path-from-shell dash helm-ag helm async helm-projectile dash projectile pkg-info epl dash helm async icicles ido-ubiquitous ido-completing-read+ js2-mode less-css-mode let-alist magit git-rebase-mode git-commit-mode multiple-cursors names paredit-everywhere paredit persp-mode persp-projectile projectile pkg-info epl dash perspective perspective php-mode popup ppd-sr-speedbar project-persist-drawer project-persist sr-speedbar project-persist-drawer project-persist projectile pkg-info epl dash smart-mode-line rich-minority smartparens dash smex sr-speedbar undo-tree web-mode workgroups2 f dash s anaphora dash xcscope yaml-mode yasnippet))

;; package
(require 'package)

(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; Graphene (saner emacs defaults)
(require 'graphene)


;; Enable commands
(put 'scroll-left 'disabled nil)

(tooltip-mode -1)
(tool-bar-mode -1)
(auto-save-mode -1)
(scroll-bar-mode -1)

;; Delete Section Mode
(delete-selection-mode 1)

(global-visual-line-mode -1)

;; Current line highlighting
(global-hl-line-mode 1)


;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; custom file
(setq custom-file (expand-file-name "custom-options.el" user-emacs-directory))
(load custom-file)


;; theme
(load-file "~/.emacs.d/themes/material-theme.el")
;; (add-to-list 'load-path "~/.emacs.d/color-theme")
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (load-file "~/.emacs.d/color-theme/themes/color-theme-sanityinc.el")
;;      (color-theme-sanityinc-dark)
;;      ;; (color-theme-deep-blue)
;;      ))

;; Custom load paths
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ede-php-autoload")
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/ac-php")


;; CEDET
;; (load-file "~/.emacs.d/site-lisp/cedet/cedet-devel-load.el")
;; (require 'ede-php-autoload-mode)


;; (semantic-load-enable-excessive-code-helpers)      ; Enable prototype help and smart completion
;; (global-srecode-minor-mode 1)            ; Enable template insertion menu

;; ;; Semantic
;; ;; (global-semantic-idle-scheduler-mode)
;; ;; (global-semantic-idle-completions-mode)
;; ;; (global-semantic-show-unmatched-syntax-mode)
;; (setq semantic-default-submodes '((global-semantic-idle-scheduler-mode)
;;                                   (global-semantic-idle-completions-mode)))

;; (semantic-mode 1)
;; ;; (require 'semantic/ia)

;; (add-hook 'semantic-mode-hook '(lambda ()
;;                                  (semantic-idle-scheduler-mode)
;;                                   (semantic-idle-completions-mode)
;;                                   (semantic-show-unmatched-syntax-mode nil)
;;                                   (semantic-decoration-mode nil)
;;                                   (semantic-highlight-func-mode nil)
;;                                   (semantic-stickyfunc-mode nil)))

;; (eval-after-load "semantic"
;;    '(progn
;; (setq semantic-default-submodes '((global-semantic-idle-scheduler-mode)
;;                                   (global-semantic-idle-completions-mode)
;;                                   (global-semantic-show-unmatched-syntax-mode nil)
;;                                   (global-semantic-decoration-mode nil)
;;                                   (global-semantic-highlight-func-mode nil)
;;                                   (global-semantic-stickyfunc-mode nil)))
;; ))



;; (when (cedet-ectag-version-check t)
;;   (semantic-load-enable-primary-exuberent-ctags-support))

;; ;; Enable EDE (Project Management) features
;; (global-ede-mode 1)


;; ;; CC-mode
;; (add-hook 'c-mode-common-hook '(lambda ()
;;         (setq ac-sources '(ac-source-semantic))
;; ))

;; ;; Load CEDET CONTRIB.
;; (load-file "~/.emacs.d/site-lisp/cedet/contrib/cedet-contrib-load.el")


;; ;; (ede-php-root-mode 1)
;; ;; (ede-php-root-project "Hypebeast"
;; ;;                       :file "~/Sites/Hypebeast/composer.json")

;; ;; (ede-php-autoload-project "Hypebeast"
;; ;;                       :file "~/Sites/Hypebeast/README.md"
;; ;;                       :class-loaders '(:psr0 (("Hypebeast" . "src/Hypebeast")
;; ;;                                               ("HypebeastStore" . "src/HypebeastStore"))))

;; (ede-php-autoload-project "Hypebeast"
;;                       :file "~/Sites/Hypebeast/README.md")


;; (add-hook 'php-mode-hook '(lambda ()
;;                             (ede-php-autoload-mode)
;;                             (php-enable-symfony2-coding-style)))


;; ido mode
;; (ido-mode 1)
;; (ido-everywhere 1)
;; (ido-ubiquitous-mode 1)
;; ;;smex
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; flx-ido
;; (require 'flx-ido)
;; (flx-ido-mode 1)
;; (setq ido-use-faces nil)



;; (require 'linum)
;; (global-linum-mode t)
;; (line-number-mode -1)
;; (add-hook 'shell-mode-hook (lambda () (linum-mode -1)))
;; (add-hook 'Info-mode-hook (lambda () (linum-mode -1)))
;; (add-hook 'magit-log-mode-hook (lambda () (linum-mode -1)))
;; (add-hook 'magit-status-mode-hook (lambda () (linum-mode -1)))
;; (add-hook 'magit-commit-mode-hook (lambda () (linum-mode -1)))




(load (concat user-emacs-directory "markdown-mode/markdown-mode.el"))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))




;; (when (string-match "^xterm" (getenv "TERM"))
;;   (load (concat user-emacs-directory "xterm-extras.el"))
;;   (require 'xterm-extras)
;;   (xterm-extra-keys))


;; start auto-complete with emacs
;; (require 'auto-complete)
;; ;; do default config for auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)

;; dirty fix for having AC everywhere
;; (define-globalized-minor-mode real-global-auto-complete-mode
;;   auto-complete-mode (lambda ()
;;                        (if (not (minibufferp (current-buffer)))
;;                            (auto-complete-mode 1))
;;                        ))
;; (real-global-auto-complete-mode t)
;; (global-auto-complete-mode)




;; eclim
;; (require 'eclim)
;; (setq eclim-auto-save nil)
;; (global-eclim-mode -1)


;; add the emacs-eclim source
;; (when (global-eclim-mode 1)
;;     (require 'ac-emacs-eclim-source)
;;     (ac-emacs-eclim-config))




;; Smartparens
;; (setq sp-highlight-pair-overlay nil)
;; (require 'smartparens-config)
;; (smartparens-global-mode)




;; Show paren mode

;; Paredit
;; (require 'paredit)
;; (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))
;; (add-hook 'web-mode-hook (lambda () (paredit-mode 1)))


;; Helm
;; (require 'helm-config)
;; (helm-mode 1)


;; Workgroup2
;; (workgroups-mode 1)


;; Aggresive indent
;; (add-hook 'web-mode-hook #'aggressive-indent-mode)


;; (require 'cl)
;;   (require 'php-mode)
;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;              (auto-complete-mode 1)
;;                (require 'ac-php)
;;                (setq ac-sources  '(ac-source-php) )
;;                (yas-global-mode 1)
;;                (php-enable-symfony2-coding-style)
;;                (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
;;                (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back) ;go back
;;                ))


;; Semantic mode
;; (semantic-mode 1)
;; (add-hook 'php-mode-hook '(lambda () (
;;     (add-to-list 'ac-sources 'ac-source-semantic)
;; )))

;; (add-to-list 'load-path "~/.emacs.d/edep")
;; (load "~/.emacs.d/edep/loaddefs.el")


(require 'custom-packages)
(require 'custom-funcs)
(require 'custom-desktop-save-mode)
(require 'custom-key-bindings)
(require 'linum-off)
