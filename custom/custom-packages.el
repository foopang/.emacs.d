;; smart-mode-line
(sml/setup)


;; ido
;; Edit as root
(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


;; recentf
(recentf-mode t)


;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
 "Never use tabs for alignment."
 (let ((indent-tabs-mode nil))
   ad-do-it))
(ad-activate 'align-regexp)
(global-set-key (kbd "C-c \\") 'align-regexp)


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
(sp-local-pair 'web-mode "{" "}" :actions nil)


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
;; (require 'ecb-autoloads)

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


;; Expand region
(global-set-key (kbd "C-=") 'er/expand-region)


;; Projectile
(projectile-global-mode)
;; (setq projectile-enable-caching t)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; AG
(setq ag-highlight-search t)


;; Perspective mode
(with-eval-after-load "persp-mode-autoloads"
  (setq wg-morph-on nil) ;; switch off animation
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))
;; (persp-mode)
(require 'persp-projectile)


;; PHP mode
;; (setq ac-php-cscope nil)
(push '("\\.php" . php-mode) auto-mode-alist)


;; SQL mode
;; (add-to-list 'ac-modes 'sql-mode)
;; (add-to-list 'ac-modes 'nxml-mode)
(add-hook 'sql-mode-hook (lambda () (electric-indent-local-mode -1)))

;; Yaml mode
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


;; Emmet-mode
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


(provide 'custom-packages)
