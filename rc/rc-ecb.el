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
 '(show-paren-mode t)
 '(ecb-tip-of-theday nil)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'ecb-show-sources-in-directories-buffer "my-own-layout")

;;(setq ecb-layout-name "my-own-layout")
(setq ecb-layout-name "left-analyse")
(setq dabbrev-case-fold-search nil)
					;(setq ecb-layout-name "my-nav")


