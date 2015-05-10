;; (setq debug-on-error t)
(setq inhibit-splash-screen t)         ; hide welcome screen
(setq inhibit-startup-message t)
;;;(setq width (max width (+ (length str) 1)))   ;line numbers
(setq-default c-basic-offset 4) ; indents 2 chars
(setq-default c-basic-indent 4)
(setq-default tab-width 4)          ; and 2 char wide for TAB
(setq-default indent-tabs-mode nil) ; And force use of spaces
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(setq tab-stop-list (number-sequence 2 200 2))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-region-up)
(global-set-key (kbd "M-<down>") 'move-region-down)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank)
)
(global-set-key (kbd "C-M-<down>") 'duplicate-line)

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r")  'rename-file-and-buffer)

(defun shift-text (distance)
  (if (use-region-p)
      (let ((mark (mark)))
        (save-excursion
          (indent-rigidly (region-beginning)
                          (region-end)
                          distance)
          (push-mark mark t t)
          (setq deactivate-mark nil)))
    (indent-rigidly (line-beginning-position)
                    (line-end-position)
                    distance)))

(defun shift-right (count)
  (interactive "p")
  (shift-text count))

(defun shift-left (count)
  (interactive "p")
  (shift-text (- count)))

(global-set-key (kbd "C-c i") (lambda () (interactive) (shift-text 4)))
(global-set-key (kbd "C-S-c i") (lambda () (interactive) (shift-text -4)))

(require 'ido)
(ido-mode t)

(require 'linum)
(global-linum-mode t)

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
     (color-theme-dark-blue2)))
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
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))


;; (load (concat user-emacs-directory "drupal/drupal-init.el"))

(load (concat user-emacs-directory "markdown-mode/markdown-mode.el"))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(tool-bar-mode -1)
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
(global-auto-complete-mode)


;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)


;; web mode
(require 'web-mode)
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
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.24516129032258063 . 0.28) (ecb-sources-buffer-name 0.24516129032258063 . 0.24) (ecb-methods-buffer-name 0.24516129032258063 . 0.28) (ecb-history-buffer-name 0.24516129032258063 . 0.18)))))
 '(ecb-options-version "2.40")
 ;; '(tool-bar-mode nil)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; eclim    
(require 'eclim)

(custom-set-variables
  '(eclim-eclipse-dirs '("/Applications/eclipse"))
  '(eclim-executable "/Applications/eclipse/eclim")
  '(eclimd-default-workspace "~/Documents/workspace"))

(setq eclim-auto-save nil)

(global-eclim-mode -1)

;; add the emacs-eclim source
;; (when (global-eclim-mode 1)
;;     (require 'ac-emacs-eclim-source)
;;     (ac-emacs-eclim-config))


;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; Smartparens
(setq sp-highlight-pair-overlay nil)
(require 'smartparens-config)
(smartparens-global-mode)


;; Undo tree
(require 'undo-tree)
(global-undo-tree-mode)


;; Desktop save mode
(load (concat user-emacs-directory "custom-desktop-save-mode.el"))
