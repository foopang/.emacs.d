;;; Load Libraries

(use-package less-css-mode  :ensure t :defer t)
(use-package undo-tree      :ensure t :defer t)

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

  (define-key company-active-map (kbd "RET") nil)

  (setq company-idle-delay 0.125
           company-minimum-prefix-length 1
           company-require-match nil
           company-transformers '(company-sort-by-occurrence)
           company-dabbrev-ignore-case nil
           company-dabbrev-downcase nil
           company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                               company-preview-frontend
                               company-echo-metadata-frontend))

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
   '(projectile-enable-caching t)
   '(projectile-completion-system 'helm))
  :config
  (defun projectile-helm-ag ()
    (interactive)
    (helm-ag (projectile-project-root)))

  ;; Load projectile globaly
  (projectile-global-mode)
  (persp-mode)
  (helm-projectile-on))

;; PHP mode
(use-package php-mode
  :ensure t
  :mode "\\.php"
  :config
  (add-hook 'php-mode-hook '(lambda()
                              (subword-mode 1)
                              (php-enable-symfony2-coding-style))))

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
(use-package markdown-mode
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

;; elpy
(use-package elpy
   :ensure t
   :config
   (elpy-enable))

;; Smart shift
(use-package smart-shift
  :ensure t
  :config
  (global-smart-shift-mode 1))

;; exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)))

;; helm
(use-package helm
  :ensure t
  :demand t
  :diminish helm-mode
  :init
  (use-package helm-config     :demand t)
  (use-package helm-descbinds  :ensure t :demand t)
  (use-package helm-flycheck   :ensure t :demand t)
  (use-package helm-hoogle     :ensure t :commands helm-hoogle)
  (use-package helm-git-grep   :ensure t :demand t)
  (use-package helm-google     :ensure t :demand t)
  (use-package helm-projectile :ensure t :demand t)
  (use-package helm-swoop      :ensure t :demand t)
  (use-package helm-ag         :ensure t :demand t)
  :bind (("C-x C-f" . helm-find-files)
         ("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-mini)
         ("C-c h o" . helm-occur)
         ("C-c h SPC" . helm-all-mark-rings)
         ("C-c h g" . helm-google-suggest)
         ("C-c h k" . helm-descbinds)
         ("C-c h a" . helm-ack)
         ("C-c h f" . helm-apropos)
         ("C-c h d" . helm-info-emacs)
         ("C-c h l" . helm-locate-library)
         ("C-c h i" . helm-semantic-or-imenu))
  :config
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

  (define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)
  (define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; From helm-swoop to helm-multi-swoop-all
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;; When doing evil-search, hand the word over to helm-swoop
  ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

  ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
  (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

  ;; Move up and down like isearch
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

  (custom-set-variables
   '(helm-command-prefix-key               "C-c h")
   '(helm-grep-default-command             "grep -a -d recurse %e -n%cH -e %p %f")
   '(helm-ack-base-command                 "ack -H --nogroup")
   '(helm-time-zone-home-location          "Berlin")
   '(helm-quick-update                     t)
   '(helm-split-window-in-side-p           t)
   '(helm-buffers-fuzzy-matching           t)
   '(helm-move-to-line-cycle-in-source     t)
   '(helm-ff-search-library-in-sexp        t)
   '(helm-scroll-amount                    8)
   '(helm-ff-file-name-history-use-recentf t)
   '(helm-recentf-fuzzy-match              t)
   '(helm-buffers-fuzzy-matching           t)
   '(helm-locate-fuzzy-match               t)
   '(helm-M-x-fuzzy-match                  t)
   '(helm-semantic-fuzzy-match             t)
   '(helm-imenu-fuzzy-match                t)
   '(helm-apropos-fuzzy-match              t)
   '(helm-swoop-move-to-line-cycle         t)
   '(helm-swoop-use-line-number-face       t)
   '(helm-swoop-split-direction            'split-window-vertically)
   '(helm-swoop-split-with-multiple-windows t))

  ;; Load helm globaly
  (helm-mode 1)
  (helm-descbinds-mode)
  (helm-autoresize-mode 1))

(provide 'custom-packages)
