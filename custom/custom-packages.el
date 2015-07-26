;;; Load Libraries

(use-package less-css-mode  :ensure t :defer t)
(use-package flx-ido        :ensure t :defer t)
(use-package ido-ubiquitous :ensure t :defer t)
(use-package smex           :ensure t :defer t)
(use-package undo-tree      :ensure t :defer t)

;; Graphene (saner emacs defaults)
(use-package graphene
  :ensure t
  :demand)

;; smart-mode-line
(use-package smart-mode-line
    :ensure t
    :demand t
    :init
    (sml/setup))

;; Company
(use-package company
  :ensure t
  :demand t
  :diminish company-mode
  :config
  (custom-set-variables
   '(company-idle-delay 0.2))

  (add-hook 'after-init-hook 'global-company-mode))

;; Magit
(use-package magit
  :ensure t
  :defer t
  :bind ("C-c g" . magit-status))

;; windmove
(use-package windmove
    :ensure t
    :bind (("C-c ! h" . windmove-left)
           ("C-c ! l" . windmove-right)
           ("C-c ! k" . windmove-up)
           ("C-c ! j" . windmove-down)))

;; web mode
(use-package web-mode
    :ensure t
    :mode (("\\.phtml\\'" . web-mode)
           ("\\.tpl\\.php\\.twig\\'" . web-mode)
           ("\\.[agj]sp\\'" . web-mode)
           ("\\.as[cp]x\\'" . web-mode)
           ("\\.erb\\'" . web-mode)
           ("\\.mustache\\'" . web-mode)
           ("\\.djhtml\\'" . web-mode)
           ("\\.html.twig\\'" . web-mode))
    :config
    (add-to-list 'web-mode-comment-formats '("php" . "//"))
    (sp-local-pair 'web-mode "{" "}" :actions nil))

;; Multiple cursors
(use-package multiple-cursors
    :ensure t
    :bind (("C-S-c C-S-c" . mc/edit-lines)
           ("C->" . mc/mark-next-like-this)
           ("C-<" . mc/mark-previous-like-this)
           ("C-c C-<" . mc/mark-all-like-this)
           ("C-c C-," . create-cursor)
           ("C-c C-." . multiple-cursors-mode))
    :init
    (setq mc/list-file (expand-file-name "mc-lists.el" user-emacs-directory))
    :config
    (defun create-cursor ()
      (interactive)
      (mc/create-fake-cursor-at-point)))

;; Expand region
(use-package expand-region
    :ensure t
    :bind ("C-=" . er/expand-region))

;; AG
(use-package ag
    :ensure t
    :init
    (setq ag-highlight-search t))

;; Perspective mode
(use-package projectile
  :ensure t
  :pin melpa-stable
  :demand t
  :diminish projectile-mode
  :init
  (use-package perspective
    :ensure t
    :demand t
    :init
    (use-package persp-projectile
      :ensure t
      :demand t))
  (custom-set-variables
   '(projectile-enable-caching t))
  :config
  ;; Load projectile globaly
  (projectile-global-mode)
  (persp-mode))

;; PHP mode
(use-package php-mode
    :ensure t
    :mode "\\.php")

;; Yaml mode
(use-package yaml-mode
    :ensure t
    :mode "\\.yml")

;; Emmet-mode
(use-package emmet-mode
    :ensure t
    :config
    (add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
    (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
)

;; Markdown mode
(use-package yaml-mode
    :ensure t
    :mode ("\\.markdown" "\\.md")
    :init
    (autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t))

;; Haskell
(use-package yaml-mode
     :ensure t
     :config
    (add-hook 'haskell-mode-hook 'haskell-indentation-mode))

;; Smart shift
(use-package smart-shift
  :ensure t
  :config
  (global-smart-shift-mode 1))

(provide 'custom-packages)
