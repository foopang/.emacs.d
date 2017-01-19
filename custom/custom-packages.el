;;; Load Libraries

(use-package less-css-mode   :ensure t :defer t)
(use-package feature-mode    :ensure t :defer t)
(use-package restclient      :ensure t :defer t)
(use-package undo-tree       :ensure t :defer t)
(use-package json-mode       :ensure t :defer t)
(use-package go-mode         :ensure t :defer t)
(use-package elixir-mode     :ensure t :defer t)
(use-package cider           :ensure t :defer t)

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
  ;; (custom-set-variables
  ;;  '(company-idle-delay 0.2))

  ;; (define-key company-active-map (kbd "RET") nil)

  (setq company-idle-delay 0.125
           company-minimum-prefix-length 1
           company-require-match nil
           company-transformers '(company-sort-by-occurrence)
           company-dabbrev-ignore-case nil
           company-dabbrev-downcase nil
           company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                               company-preview-frontend
                               company-echo-metadata-frontend)
           company-backends '(company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf
                  (company-dabbrev-code company-gtags company-keywords)
                  company-oddmuse company-files company-dabbrev))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

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
         ("\\.tpl\\.twig\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html.twig\\'" . web-mode))
  :init
  ;; (setq web-mode-enable-auto-pairing nil)
  :config
  ;; (add-to-list 'web-mode-comment-formats '("php" . "//"))


  (add-hook 'web-mode-hook '(lambda()
                              (electric-pair-local-mode -1)))

  ;; (when (and (boundp 'electric-pair-mode)
  ;;           (boundp 'electric-pair-inhibit-predicate))
  ;;   (set (make-local-variable 'electric-pair-inhibit-predicate)
  ;;        (lambda (char) t)))

  ;; (set (make-local-variable 'electric-pair-mode) -1)
  )

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
  ;; (defun projectile-helm-ag ()
  ;;   (interactive)
  ;;   (helm-ag (projectile-project-root)))

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

(use-package typescript-mode
  :ensure t
  :mode "\\.ts"
  :init
  (use-package tide :ensure t :demand t)
  (add-hook 'custom-set-current-indentation-hook '(lambda() (setq typescript-indent-level tab-width)))
  (add-hook 'after-init-hook (lambda() (set-variable 'tide-supported-modes '(typescript-mode js-mode js2-mode js2-jsx-mode js3-mode))))
  (add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode +1)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)
            (company-mode +1))))

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

;; AUCTeX
(use-package tex-site
  :ensure auctex
  :config
  (setq Tex-engine 'xetex)
  (add-hook 'LaTeX-mode-hook
          (lambda()
             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
             (setq TeX-command-default "XeLaTeX")
             (setq TeX-save-query nil)
             (setq TeX-show-compilation t))))

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
  (use-package helm-css-scss   :ensure t :demand t)
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
   '(helm-swoop-split-with-multiple-windows t)
   '(helm-ag-use-agignore                  t))

  ;; Load helm globaly
  (helm-mode 1)
  (helm-descbinds-mode)
  (helm-autoresize-mode 1))

;; ob-http
(use-package ob-http
  :ensure t
  :defer t
  :init
  (org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (http . t))))

;; js2-mode
(use-package js2-mode
  :ensure t
  :diminish js2-mode
  :init
  (setq js2-strict-missing-semi-warning nil)
  :config
  (add-hook 'js-mode-hook 'js2-minor-mode))

;; mmm-mode
(use-package mmm-mode
  :ensure t
  :init
  (setq mmm-global-mode 'maybe)

  (dolist (langsets '(("script" . ((es6    . js2-mode)))
                      ("style"  . ((less   . less-css-mode)))))
    (let ((tag (car langsets)))
      (dolist (pair (cdr langsets))
        (let* ((lang       (car pair))
               (submode    (cdr pair))
               (class-name (make-symbol (format "vueify-%s-%s" tag lang)))
               (front      (format "<%s lang=\"%s\">" tag lang))
               (back       (format "</%s>" tag)))
          (mmm-add-classes
           `((,class-name
              :submode ,submode
              :front ,front
              :back ,back)))
          (mmm-add-mode-ext-class nil "\\.vue?\\'" class-name)))))

  (add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode)))

(use-package tern
  :load-path tern-dir
  :diminish tern-mode
  :ensure t
  :init
  (use-package company-tern
    :ensure t
    :demand t
    :config
    (add-to-list 'company-backends 'company-tern))
  :config
  (add-hook 'js-mode-hook (lambda () (tern-mode t))))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(provide 'custom-packages)
