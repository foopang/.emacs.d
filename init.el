(setq indent-line-function 'insert-tab)

(setq semantic-ectags-program "/usr/local/bin/ctags")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(setq package-list '(graphene company flycheck let-alist pkg-info epl dash smartparens dash web-mode smex sr-speedbar ppd-sr-speedbar project-persist-drawer project-persist sr-speedbar exec-path-from-shell dash graphene ag s dash aggressive-indent names auto-complete popup ecb emacs-eclim s emmet-mode etags-select expand-region feature-mode flatland-theme flx-ido flx graphene company flycheck let-alist pkg-info epl dash smartparens dash web-mode smex sr-speedbar ppd-sr-speedbar project-persist-drawer project-persist sr-speedbar exec-path-from-shell dash helm-ag helm async helm-projectile dash projectile pkg-info epl dash helm async icicles ido-ubiquitous ido-completing-read+ js2-mode less-css-mode let-alist magit git-rebase-mode git-commit-mode markdown-mode multiple-cursors names paredit-everywhere paredit persp-mode persp-projectile projectile pkg-info epl dash perspective perspective php-mode popup ppd-sr-speedbar project-persist-drawer project-persist sr-speedbar project-persist-drawer project-persist projectile pkg-info epl dash smart-mode-line rich-minority smartparens dash smex sr-speedbar undo-tree web-mode workgroups2 f dash s anaphora dash xcscope yaml-mode yasnippet))

;; Enable commands
(put 'scroll-left 'disabled nil)

;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)


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


;; custom file
(setq custom-file (expand-file-name "custom-options.el" user-emacs-directory))
(load custom-file)


;; theme
(load-file "~/.emacs.d/themes/material-theme.el")

;; Custom load paths
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ede-php-autoload")


;; CEDET
;; (load-file "~/.emacs.d/site-lisp/cedet/cedet-devel-load.el")
;; (load-file "~/.emacs.d/site-lisp/cedet/contrib/cedet-contrib-load.el")

;; (require 'wisent-php)
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
;; (require 'semantic/ia)

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
(global-ede-mode 1)

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
;;                       :file "~/www/Hypebeast/README.md")

;; (ede-php-autoload-project "symfony-test"
;;                       :file "/usr/local/var/www/symfony-test/composer.json")


;; (add-hook 'php-mode-hook '(lambda ()
;;                             (ede-php-autoload-mode)
;;                             (php-enable-symfony2-coding-style)))

;; (add-hook 'php-mode-hook #'ede-php-autoload-mode)


(require 'custom-packages)
(require 'custom-funcs)
(require 'custom-desktop-save-mode)
(require 'custom-key-bindings)
(require 'linum-off)
