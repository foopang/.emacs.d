(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/rc")

(require 'cl)

;;(progn (cd "~/.emacs.d/site-lisp")
;;       (normal-top-level-add-subdirs-to-load-path)
;;       (cd "~"))

(load "rc-init.el")
(load "rc-auto-insert.el")
(load "rc-ccmode.el")
(load "rc-cedet.el")
(load "rc-ecb.el")
(load "rc-gdb.el")
;;(load "rc-haskell.el")
(load "rc-html.el")
;;(load "rc-java.el")
;;(load "rc-javascript.el")
(load "rc-php.el")
(load "rc-yasnippet.el")
(load "rc-python.el")
(load "rc-w3m.el")
(load "rc-yaml.el")


(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

;;(add-to-list 'load-path "~/.emacs.d/themes")
;;(when (require 'jao-themes nil t)
;;  (enable-theme 'jao-dark))

;; init color-theme
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme-6.6.0/")
(require 'color-theme)
;;(load-file "~/.emacs.d/themes/color-theme-almost-monokai.el")
(load-file "~/.emacs.d/themes/color-theme-jeff.el")
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;;(color-theme-blue-mood)
     (color-theme-jeff)
     ;;(color-theme-almost-monokai)
))

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
  ;;(message "autopiars call")
  (let (pair)
    (dolist (pair skeleton-pair-alist)
      (when (eq (char-after) (car (last pair)))
	(save-excursion (newline-and-indent))))
    (newline arg)
    (indent-according-to-mode)))
;;(eldoc-add-command 'autopairs-ret) ; if using ElDoc
(global-set-key (kbd "RET") 'autopairs-ret)



;; customizations
;;(setq custom-file "~/.emacs.d/custom.el")
;;(load custom-file)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("~/prj")))
 '(ecb-tip-of-theday nil)
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
 '(semantic-decoration-on-private-members-face ((((class color) (background light)) (:background "#e3d5c1")))))
