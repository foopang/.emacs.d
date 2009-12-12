(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/rc")
;;(progn (cd "~/.emacs.d/site-lisp")
;;       (normal-top-level-add-subdirs-to-load-path)
;;       (cd "~"))

(load "rc-init.el")
(load "rc-ccmode.el")
(load "rc-cedet.el")
(load "rc-python.el")
(load "rc-javascript.el")
(load "rc-php.el")

;;(require 'ec-python)

;; init color-theme
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme-6.6.0/")
(require 'color-theme)
(load-file "~/.emacs.d/themes/color-theme-almost-monokai.el")
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-blue-mood)
     ;;(color-theme-almost-monokai)
))



;; jdee
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/cedet-1.0pre6/common")
(add-to-list 'load-path "~/.emacs.d/site-lisp/cedet-cvs/common")
(add-to-list 'load-path "~/.emacs.d/site-lisp/jde-2.4.0/lisp")
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/cedet/common"))
;;(add-to-list 'load-path (expand-file-name "~/emacs/site/cedet/common"))
;;(load-file (expand-file-name "~/emacs/site/cedet/common/cedet.el"))
(add-to-list 'load-path "~/.emacs.d/site-lisp/elib-1.0")

(load "jde-autoload")

;; haskell
(load "~/.emacs.d/site-lisp/haskell-mode-2.4/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


;; auto pair
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;; textmate mode
;(load "textmate-0.1.el")

(setq skeleton-pair t)
(setq skeleton-pair-alist
      '((?\( _ ?\))
	(?[  _ ?])
	(?{  _ ?})
	(?\" _ ?\")))

(defun autopairs-ret (arg)
  (interactive "P")
  (let (pair)
    (dolist (pair skeleton-pair-alist)
      (when (eq (char-after) (car (last pair)))
	(save-excursion (newline-and-indent))))
    (newline arg)
    (indent-according-to-mode)))
;;(eldoc-add-command 'autopairs-ret) ; if using ElDoc
(global-set-key (kbd "RET") 'autopairs-ret)



;; ECB
(add-to-list 'load-path
             "~/.emacs.d/site-lisp/ecb-snap")

(require 'ecb)

(ecb-layout-define "my-own-layout" left
  ;; The frame is already splitted side-by-side and point stays in the
  ;; left window (= the ECB-tree-window-column)
   
  ;; Here is the creation code for the new layout
   
  ;; 1. Defining the current window/buffer as ECB-methods buffer
  ;(ecb-set-sources-buffer)
  (ecb-set-directories-buffer)
  ;; 2. Splitting the ECB-tree-windows-column in two windows
  ;(ecb-split-ver 0.75 t)
  ;; 3. Go to the second window
  ;(other-window 1)
  ;; 4. Defining the current window/buffer as ECB-history buffer
  ;(ecb-set-history-buffer)
  ;; 5. Make the ECB-edit-window current (see Postcondition above)
  (select-window (next-window)))

;(require 'ecb-autoloads)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("~/prj")))
 '(ecb-windows-width 0.2)
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 '(semantic-idle-scheduler-idle-time 3)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(add-to-list 'ecb-show-sources-in-directories-buffer "my-own-layout")

(setq ecb-layout-name "my-own-layout")
(setq dabbrev-case-fold-search nil)
;(setq ecb-layout-name "my-nav")


;; copy-line
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))
 
(setq-default kill-read-only-ok t)
(global-set-key "\C-c\C-k" 'copy-line)


;; open new line

    ;; Behave like vi's o command
    (defun open-next-line (arg)
      "Move to the next line and then opens a line.
    See also `newline-and-indent'."
      (interactive "p")
      (end-of-line)
      (open-line arg)
      (next-line 1)
      (when newline-and-indent
        (indent-according-to-mode)))

    (global-set-key (kbd "C-o") 'open-next-line)

    ;; Behave like vi's O command
    (defun open-previous-line (arg)
      "Open a new line before the current one. 
     See also `newline-and-indent'."
      (interactive "p")
      (beginning-of-line)
      (open-line arg)
      (when newline-and-indent
        (indent-according-to-mode)))

    (global-set-key (kbd "M-o") 'open-previous-line)
 
    ;; Autoindent open-*-lines
    (defvar newline-and-indent t
      "Modify the behavior of the open-*-line functions to cause them to autoindent.")

    (global-set-key [S-return]   'open-next-line)
    (global-set-key [C-S-return] 'open-previous-line)


;; textmate
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;; anything
(require 'anything-etags)
(setq anything-sources
      '(
	anything-c-source-buffers
	anything-c-source-etags-select
        ))

(require 'anything-config)
;;(require 'anything-etags)
;;(setq anything-sources
;;      '(anything-c-source-buffers
;;        anything-c-source-buffer-not-found
;;        anything-c-source-file-name-history
;;        anything-c-source-info-pages
;;        anything-c-source-info-elisp
;;        anything-c-source-man-pages
;;        anything-c-source-locate
;;        anything-c-source-emacs-commands
;;        ))

;; (setq anything-sources
;;       '(anything-etags-c-source-etags-select
;;        ))


;;(setq anything-sources
;;      '(anything-etags-c-source-etags-select
;;       ))
